import pool from '../config/database.js';
import { BaseRepository } from './baseRepository.js';

class SettingsRepository extends BaseRepository {
  constructor() {
    super('settings');
  }

  async getAllGrouped() {
    const [rows] = await pool.execute('SELECT * FROM settings ORDER BY setting_group, setting_key');
    const grouped = {};
    rows.forEach((row) => {
      if (!grouped[row.setting_group]) grouped[row.setting_group] = {};
      grouped[row.setting_group][row.setting_key] = row.setting_value;
    });
    return grouped;
  }

  async getByKey(key) {
    const [rows] = await pool.execute('SELECT setting_value FROM settings WHERE setting_key = ?', [key]);
    return rows[0]?.setting_value || null;
  }

  async upsert(key, value, group = 'general') {
    await pool.execute(
      `INSERT INTO settings (setting_key, setting_value, setting_group) VALUES (?, ?, ?)
       ON DUPLICATE KEY UPDATE setting_value = ?, updated_at = CURRENT_TIMESTAMP`,
      [key, value, group, value]
    );
  }
}

export default new SettingsRepository();
