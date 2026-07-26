import pool from '../config/database.js';
import { BaseRepository } from './baseRepository.js';

class ServiceRepository extends BaseRepository {
  constructor() {
    super('services');
  }

  async findAllActive() {
    const [rows] = await pool.execute(
      'SELECT * FROM services WHERE is_active = 1 ORDER BY sort_order ASC'
    );
    return rows;
  }

  async findMainServices() {
    const [rows] = await pool.execute(
      'SELECT * FROM services WHERE parent_id IS NULL AND is_active = 1 ORDER BY sort_order ASC'
    );
    return rows;
  }

  async findWithSubServices(slug) {
    const service = await this.findBySlug(slug);
    if (!service) return null;

    const [subServices] = await pool.execute(
      'SELECT * FROM services WHERE parent_id = ? AND is_active = 1 ORDER BY sort_order ASC',
      [service.id]
    );

    const [gallery] = await pool.execute(
      'SELECT * FROM media_library WHERE folder = ? ORDER BY created_at DESC LIMIT 12',
      [`service-${service.id}`]
    ).catch(() => [[]]);

    return { ...service, sub_services: subServices, gallery: gallery || [] };
  }
}

export default new ServiceRepository();
