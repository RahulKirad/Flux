import pool from '../config/database.js';
import { BaseRepository } from './baseRepository.js';

class FacilityRepository extends BaseRepository {
  constructor() {
    super('facilities');
  }

  async findAllWithGallery() {
    const facilities = await this.findAll({ where: 'is_active = 1', orderBy: 'sort_order ASC' });
    const result = [];
    for (const facility of facilities) {
      const [gallery] = await pool.execute(
        'SELECT * FROM facility_gallery WHERE facility_id = ? ORDER BY sort_order ASC',
        [facility.id]
      );
      result.push({ ...facility, gallery });
    }
    return result;
  }

  async findBySlugWithGallery(slug) {
    const facility = await this.findBySlug(slug);
    if (!facility) return null;

    const [gallery] = await pool.execute(
      'SELECT * FROM facility_gallery WHERE facility_id = ? ORDER BY sort_order ASC',
      [facility.id]
    );
    return { ...facility, gallery };
  }
}

export default new FacilityRepository();
