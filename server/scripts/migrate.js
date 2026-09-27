import fs from 'fs/promises';
import path from 'path';
import { fileURLToPath } from 'url';
import mysql from 'mysql2/promise';
import dotenv from 'dotenv';

dotenv.config();

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const migrationsDir = path.join(__dirname, '../../database/migrations');

const dbName = process.env.DB_NAME || 'flux_corp';
const baseConfig = {
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || '',
};

async function ensureDatabase() {
  const conn = await mysql.createConnection(baseConfig);
  await conn.execute(
    `CREATE DATABASE IF NOT EXISTS \`${dbName}\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci`,
  );
  await conn.end();
}

async function ensureMigrationsTable(conn) {
  await conn.execute(`
    CREATE TABLE IF NOT EXISTS schema_migrations (
      id INT AUTO_INCREMENT PRIMARY KEY,
      name VARCHAR(255) NOT NULL UNIQUE,
      applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
  `);
}

async function getAppliedMigrations(conn) {
  const [rows] = await conn.execute('SELECT name FROM schema_migrations ORDER BY id');
  return new Set(rows.map((r) => r.name));
}

async function listMigrationFiles() {
  const entries = await fs.readdir(migrationsDir);
  return entries
    .filter((f) => f.endsWith('.sql'))
    .sort((a, b) => a.localeCompare(b));
}

async function runMigration(conn, filename) {
  const filePath = path.join(migrationsDir, filename);
  const sql = await fs.readFile(filePath, 'utf8');
  if (!sql.trim()) {
    throw new Error(`Migration ${filename} is empty`);
  }

  await conn.beginTransaction();
  try {
    await conn.query({ sql, multipleStatements: true });
    await conn.execute('INSERT INTO schema_migrations (name) VALUES (?)', [filename]);
    await conn.commit();
  } catch (err) {
    await conn.rollback();
    throw err;
  }
}

async function main() {
  console.log(`Flux Corp — database migrations (database: ${dbName})`);

  try {
    await ensureDatabase();
  } catch (err) {
    if (err.code === 'ECONNREFUSED' || err.errno === 2002) {
      console.error('\nCould not connect to MySQL. Start MySQL and check server/.env (DB_HOST, DB_USER, DB_PASSWORD).\n');
      process.exit(1);
    }
    throw err;
  }

  const conn = await mysql.createConnection({ ...baseConfig, database: dbName, multipleStatements: true });
  await ensureMigrationsTable(conn);

  const applied = await getAppliedMigrations(conn);
  const files = await listMigrationFiles();

  if (files.length === 0) {
    console.error(`No .sql files found in ${migrationsDir}`);
    process.exit(1);
  }

  let ran = 0;
  for (const file of files) {
    if (applied.has(file)) {
      console.log(`  skip  ${file}`);
      continue;
    }
    console.log(`  apply ${file}`);
    await runMigration(conn, file);
    ran += 1;
  }

  await conn.end();

  if (ran === 0) {
    console.log('\nDatabase is up to date.');
  } else {
    console.log(`\nApplied ${ran} migration(s).`);
    console.log('Optional: cd server && npm run seed:admin  (admin / admin@Flux2026)');
  }
}

main().catch((err) => {
  console.error('\nMigration failed:', err.message || err);
  if (err.sql) console.error(err.sql.slice(0, 200));
  process.exit(1);
});
