import pool from '../config/database.js';
import { BaseRepository } from './baseRepository.js';

class CertificationRepository extends BaseRepository {
  constructor() {
    super('certifications');
  }

  async findAllActive() {
    return this.findAll({ where: 'is_active = 1', params: [], orderBy: 'sort_order ASC' });
  }
}

export default new CertificationRepository();
