import pool from '../config/database.js';
import { BaseRepository } from './baseRepository.js';

class CaseStudyRepository extends BaseRepository {
  constructor() {
    super('case_studies');
  }

  async findAllPublic({ industry, featured, limit = 20, offset = 0 } = {}) {
    let where = 'cs.is_active = 1';
    const params = [];

    if (industry) {
      where += ' AND i.slug = ?';
      params.push(industry);
    }
    if (featured === 'true') {
      where += ' AND cs.is_featured = 1';
    }

    const [rows] = await pool.execute(
      `SELECT cs.*, i.title as industry_name
       FROM case_studies cs LEFT JOIN industries i ON cs.industry_id = i.id
       WHERE ${where} ORDER BY cs.created_at DESC LIMIT ? OFFSET ?`,
      [...params, parseInt(limit), parseInt(offset)]
    );
    return rows;
  }
}

export default new CaseStudyRepository();
