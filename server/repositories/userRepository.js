import pool from '../config/database.js';
import { BaseRepository } from './baseRepository.js';

class UserRepository extends BaseRepository {
  constructor() {
    super('users');
  }

  async findByEmail(email) {
    const [rows] = await pool.execute(
      `SELECT u.*, r.name as role_name, r.slug as role_slug, r.permissions
       FROM users u JOIN roles r ON u.role_id = r.id WHERE u.email = ?`,
      [email]
    );
    return rows[0] || null;
  }

  /** Email, or username alias \`admin\` for the primary super-admin account */
  async findByLogin(login) {
    const identifier = (login || '').trim();
    if (!identifier) return null;

    if (identifier.toLowerCase() === 'admin') {
      return this.findByEmail('admin@fluxcorp.com');
    }

    const byEmail = await this.findByEmail(identifier);
    if (byEmail) return byEmail;

    const [rows] = await pool.execute(
      `SELECT u.*, r.name as role_name, r.slug as role_slug, r.permissions
       FROM users u JOIN roles r ON u.role_id = r.id
       WHERE LOWER(u.name) = LOWER(?) LIMIT 1`,
      [identifier]
    );
    return rows[0] || null;
  }

  async findAllWithRole() {
    const [rows] = await pool.execute(
      `SELECT u.id, u.name, u.email, u.phone, u.is_active, u.last_login, u.created_at,
              r.name as role_name, r.slug as role_slug
       FROM users u JOIN roles r ON u.role_id = r.id ORDER BY u.created_at DESC`
    );
    return rows;
  }
}

export default new UserRepository();
