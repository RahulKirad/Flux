import bcrypt from 'bcryptjs';
import mysql from 'mysql2/promise';
import dotenv from 'dotenv';

dotenv.config();

const email = 'admin@fluxcorp.com';
const password = 'admin@Flux2026';
const dbName = process.env.DB_NAME || 'flux_corp';

const config = {
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || '',
  database: dbName,
};

let pool;

try {
  pool = await mysql.createPool(config);
  await pool.execute('SELECT 1');
} catch (err) {
  if (err.code === 'ER_BAD_DB_ERROR') {
    console.error(`Unknown database "${dbName}".\n`);
    console.error('Run:\n');
    console.error('  cd server && npm run migrate');
    console.error('  cd server && npm run seed:admin\n');
    console.error('(Use your MySQL username/password if not root.)');
    process.exit(1);
  }
  if (err.code === 'ECONNREFUSED' || err.errno === 2002) {
    console.error('MySQL is not running or not reachable. Start MySQL, then try again.');
    process.exit(1);
  }
  throw err;
}

const hash = await bcrypt.hash(password, 10);

try {
  const [rows] = await pool.execute('SELECT id FROM users WHERE email = ?', [email]);
  if (rows.length) {
    await pool.execute(
      'UPDATE users SET password = ?, name = ?, is_active = 1, role_id = 1 WHERE email = ?',
      [hash, 'Super Admin', email],
    );
    console.log(`Updated admin user (${email}).`);
  } else {
    await pool.execute(
      'INSERT INTO users (role_id, name, email, password, is_active) VALUES (1, ?, ?, ?, 1)',
      ['Super Admin', email, hash],
    );
    console.log('Created admin user.');
  }
  console.log(`Login at /admin — username: admin — password: ${password}`);
} catch (err) {
  if (err.code === 'ER_NO_SUCH_TABLE') {
    console.error('The users table is missing. Run migrations first:\n');
    console.error('  cd server && npm run db:setup\n');
    console.error('  (or: npm run migrate && npm run seed:admin)\n');
    process.exit(1);
  }
  throw err;
} finally {
  await pool.end();
}

process.exit(0);
