import pool from '../config/database.js';
import { BaseRepository } from './baseRepository.js';

class IndustryRepository extends BaseRepository {
  constructor() {
    super('industries');
  }

  async findAllActive() {
    return this.findAll({ where: 'is_active = 1', params: [], orderBy: 'sort_order ASC' });
  }

  async findBySlugWithDetails(slug) {
    const industry = await this.findBySlug(slug);
    if (!industry) return null;

    const [projects] = await pool.execute(
      'SELECT id, title, slug, banner, short_description FROM projects WHERE industry_id = ? AND is_active = 1 LIMIT 6',
      [industry.id]
    );

    const [caseStudies] = await pool.execute(
      'SELECT id, title, slug, banner, outcome FROM case_studies WHERE industry_id = ? AND is_active = 1 LIMIT 4',
      [industry.id]
    );

    return { ...industry, projects, case_studies: caseStudies };
  }
}

export default new IndustryRepository();
