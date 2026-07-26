import pool from '../config/database.js';
import { BaseRepository } from './baseRepository.js';

class ProjectRepository extends BaseRepository {
  constructor() {
    super('projects');
  }

  async findAllPublic({ industry, category, search, featured, limit = 20, offset = 0 } = {}) {
    let where = 'p.is_active = 1';
    const params = [];

    if (industry) {
      where += ' AND i.slug = ?';
      params.push(industry);
    }
    if (category) {
      where += ' AND p.category = ?';
      params.push(category);
    }
    if (featured === 'true') {
      where += ' AND p.is_featured = 1';
    }
    if (search) {
      where += ' AND (p.title LIKE ? OR p.short_description LIKE ?)';
      params.push(`%${search}%`, `%${search}%`);
    }

    const [rows] = await pool.execute(
      `SELECT p.*, i.title as industry_name, i.slug as industry_slug
       FROM projects p LEFT JOIN industries i ON p.industry_id = i.id
       WHERE ${where} ORDER BY p.created_at DESC LIMIT ? OFFSET ?`,
      [...params, parseInt(limit), parseInt(offset)]
    );
    return rows;
  }

  async findBySlugWithDetails(slug) {
    const [rows] = await pool.execute(
      `SELECT p.*, i.title as industry_name, s.title as service_name
       FROM projects p
       LEFT JOIN industries i ON p.industry_id = i.id
       LEFT JOIN services s ON p.service_id = s.id
       WHERE p.slug = ? AND p.is_active = 1`,
      [slug]
    );
    if (!rows.length) return null;

    const [gallery] = await pool.execute(
      'SELECT * FROM project_gallery WHERE project_id = ? ORDER BY sort_order ASC',
      [rows[0].id]
    );

    return { ...rows[0], gallery };
  }
}

export default new ProjectRepository();
