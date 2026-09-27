import mysql from 'mysql2/promise';
import dotenv from 'dotenv';

dotenv.config();

const dbName = process.env.DB_NAME || 'flux_corp';

const config = {
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || '',
};

try {
  const conn = await mysql.createConnection(config);
  await conn.execute(
    `CREATE DATABASE IF NOT EXISTS \`${dbName}\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci`,
  );
  await conn.end();
  console.log(`Database "${dbName}" is ready.`);
  console.log('');
  console.log('Next, run migrations:');
  console.log('  cd server && npm run migrate');
  console.log('');
  console.log('Then create the admin user:');
  console.log('  cd server && npm run seed:admin');
} catch (err) {
  if (err.code === 'ECONNREFUSED' || err.code === 'ENOTFOUND' || err.errno === 2002) {
    console.error('Could not connect to MySQL. Start your MySQL server first (Homebrew, MAMP, Docker, etc.).');
    console.error(`  Host: ${config.host}, user: ${config.user}`);
  } else {
    console.error(err.message || err);
  }
  process.exit(1);
}
