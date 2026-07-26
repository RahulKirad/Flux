import pool from '../config/database.js';
import { BaseRepository } from './baseRepository.js';

class BlogRepository extends BaseRepository {
  constructor() {
    super('blogs');
  }

  async findPublished({ category, tag, search, limit = 10, offset = 0 } = {}) {
    let where = 'b.is_published = 1';
    const params = [];

    if (category) {
      where += ' AND bc.slug = ?';
      params.push(category);
    }
    if (search) {
      where += ' AND (b.title LIKE ? OR b.excerpt LIKE ?)';
      params.push(`%${search}%`, `%${search}%`);
    }

    const [rows] = await pool.execute(
      `SELECT b.*, bc.name as category_name, bc.slug as category_slug, u.name as author_name
       FROM blogs b
       LEFT JOIN blog_categories bc ON b.category_id = bc.id
       LEFT JOIN users u ON b.author_id = u.id
       WHERE ${where} ORDER BY b.published_at DESC LIMIT ? OFFSET ?`,
      [...params, parseInt(limit), parseInt(offset)]
    );
    return rows;
  }

  async findBySlugPublished(slug) {
    const [rows] = await pool.execute(
      `SELECT b.*, bc.name as category_name, u.name as author_name
       FROM blogs b
       LEFT JOIN blog_categories bc ON b.category_id = bc.id
       LEFT JOIN users u ON b.author_id = u.id
       WHERE b.slug = ? AND b.is_published = 1`,
      [slug]
    );
    if (rows.length) {
      await pool.execute('UPDATE blogs SET views = views + 1 WHERE id = ?', [rows[0].id]);
    }
    return rows[0] || null;
  }
}

export default new BlogRepository();
