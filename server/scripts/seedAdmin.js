import bcrypt from 'bcryptjs';
import pool from '../config/database.js';

const password = await bcrypt.hash('Admin@123', 10);
await pool.execute('UPDATE users SET password = ? WHERE email = ?', [password, 'admin@fluxcorp.com']);
console.log('Admin password reset to: Admin@123');
process.exit(0);
