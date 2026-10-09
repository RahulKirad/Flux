import fs from 'fs/promises';
import path from 'path';
import { fileURLToPath, pathToFileURL } from 'url';
import mysql from 'mysql2/promise';
import dotenv from 'dotenv';

dotenv.config();

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const dbName = process.env.DB_NAME || 'flux_corp';
const baseConfig = {
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || '',
};

async function pathExists(dir) {
  try {
    const stat = await fs.stat(dir);
    return stat.isDirectory();
  } catch {
    return false;
  }
}

async function resolveMigrationsDir() {
  const candidates = [
    path.join(__dirname, '../../database/migrations'),
    path.join(__dirname, '../database/migrations'),
    path.join(process.cwd(), 'database/migrations'),
    path.join(process.cwd(), '../database/migrations'),
  ];

  for (const dir of candidates) {
    if (await pathExists(dir)) {
      return dir;
    }
  }

  throw new Error(
    `Could not find database/migrations. Looked in:\n${candidates.map((d) => `  - ${d}`).join('\n')}`,
  );
}

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

async function listMigrationFiles(migrationsDir) {
  const entries = await fs.readdir(migrationsDir);
  return entries
    .filter((f) => f.endsWith('.sql'))
    .sort((a, b) => a.localeCompare(b));
}

async function tableExists(conn, tableName) {
  const [rows] = await conn.execute(
    `SELECT 1 FROM information_schema.tables
     WHERE table_schema = ? AND table_name = ?
     LIMIT 1`,
    [dbName, tableName],
  );
  return rows.length > 0;
}

async function baselineExistingDatabase(conn, files) {
  const applied = await getAppliedMigrations(conn);
  if (applied.size > 0) return applied;
  if (!(await tableExists(conn, 'roles'))) return applied;

  console.log('Existing database found. Recording current migration files as already applied.');
  for (const file of files) {
    await conn.execute('INSERT IGNORE INTO schema_migrations (name) VALUES (?)', [file]);
  }
  return new Set(files);
}

async function runMigration(conn, migrationsDir, filename) {
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

export async function runPendingMigrations() {
  const migrationsDir = await resolveMigrationsDir();
  console.log(`Flux Corp — database migrations (database: ${dbName})`);
  console.log(`Migrations folder: ${migrationsDir}`);

  await ensureDatabase();

  const conn = await mysql.createConnection({ ...baseConfig, database: dbName, multipleStatements: true });
  try {
    await ensureMigrationsTable(conn);

    const files = await listMigrationFiles(migrationsDir);
    if (files.length === 0) {
      throw new Error(`No .sql files found in ${migrationsDir}`);
    }

    const applied = await baselineExistingDatabase(conn, files);
    let ran = 0;

    for (const file of files) {
      if (applied.has(file)) {
        console.log(`  skip  ${file}`);
        continue;
      }
      console.log(`  apply ${file}`);
      await runMigration(conn, migrationsDir, file);
      ran += 1;
    }

    if (ran === 0) {
      console.log('Database is up to date.');
    } else {
      console.log(`Applied ${ran} migration(s).`);
    }

    return { ran, skipped: files.length - ran, dir: migrationsDir };
  } finally {
    await conn.end();
  }
}

const isCli = process.argv[1] && pathToFileURL(path.resolve(process.argv[1])).href === import.meta.url;

if (isCli) {
  runPendingMigrations().catch((err) => {
    console.error('\nMigration failed:', err.message || err);
    if (err.sql) console.error(err.sql.slice(0, 200));
    process.exit(1);
  });
}
