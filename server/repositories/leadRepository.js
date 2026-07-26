import pool from '../config/database.js';
import { BaseRepository } from './baseRepository.js';

class LeadRepository extends BaseRepository {
  constructor() {
    super('leads');
  }

  async findAllWithDetails({ status, source, limit = 50, offset = 0 } = {}) {
    let where = '1=1';
    const params = [];

    if (status) {
      where += ' AND l.status = ?';
      params.push(status);
    }
    if (source) {
      where += ' AND l.source = ?';
      params.push(source);
    }

    const [rows] = await pool.execute(
      `SELECT l.*, s.title as service_title, u.name as assigned_name
       FROM leads l
       LEFT JOIN services s ON l.service_id = s.id
       LEFT JOIN users u ON l.assigned_to = u.id
       WHERE ${where} ORDER BY l.created_at DESC LIMIT ? OFFSET ?`,
      [...params, parseInt(limit), parseInt(offset)]
    );
    return rows;
  }

  async getStats() {
    const [stats] = await pool.execute(`
      SELECT
        COUNT(*) as total,
        SUM(CASE WHEN status = 'new' THEN 1 ELSE 0 END) as new_leads,
        SUM(CASE WHEN status = 'won' THEN 1 ELSE 0 END) as won,
        SUM(CASE WHEN DATE(created_at) = CURDATE() THEN 1 ELSE 0 END) as today
      FROM leads
    `);
    return stats[0];
  }
}

export default new LeadRepository();
