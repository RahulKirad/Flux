import pool from '../config/database.js';
import { BaseRepository } from './baseRepository.js';

class MediaRepository extends BaseRepository {
  constructor() {
    super('media_library');
  }

  async findByType(fileType, { folder, limit = 50, offset = 0 } = {}) {
    let where = 'file_type = ?';
    const params = [fileType];

    if (folder) {
      where += ' AND folder = ?';
      params.push(folder);
    }

    const [rows] = await pool.execute(
      `SELECT * FROM media_library WHERE ${where} ORDER BY created_at DESC LIMIT ? OFFSET ?`,
      [...params, parseInt(limit), parseInt(offset)]
    );
    return rows;
  }
}

export default new MediaRepository();
