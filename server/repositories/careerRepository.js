import pool from '../config/database.js';
import { BaseRepository } from './baseRepository.js';

class CareerRepository extends BaseRepository {
  constructor() {
    super('careers');
  }

  async findAllActive() {
    return this.findAll({ where: 'is_active = 1', orderBy: 'posted_at DESC' });
  }
}

class ApplicationRepository extends BaseRepository {
  constructor() {
    super('applications');
  }

  async findByCareer(careerId) {
    const [rows] = await pool.execute(
      'SELECT * FROM applications WHERE career_id = ? ORDER BY created_at DESC',
      [careerId]
    );
    return rows;
  }
}

export const careerRepository = new CareerRepository();
export const applicationRepository = new ApplicationRepository();
