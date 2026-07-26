import pool from '../config/database.js';

export class BaseRepository {
  constructor(table) {
    this.table = table;
    this.pool = pool;
  }

  async findAll({ where = '', params = [], orderBy = 'id DESC', limit, offset } = {}) {
    let sql = `SELECT * FROM ${this.table}`;
    if (where) sql += ` WHERE ${where}`;
    sql += ` ORDER BY ${orderBy}`;
    if (limit) {
      sql += ` LIMIT ${limit}`;
      if (offset) sql += ` OFFSET ${offset}`;
    }
    const [rows] = await this.pool.execute(sql, params);
    return rows;
  }

  async findById(id) {
    const [rows] = await this.pool.execute(`SELECT * FROM ${this.table} WHERE id = ?`, [id]);
    return rows[0] || null;
  }

  async findBySlug(slug) {
    const [rows] = await this.pool.execute(`SELECT * FROM ${this.table} WHERE slug = ?`, [slug]);
    return rows[0] || null;
  }

  async count(where = '', params = []) {
    let sql = `SELECT COUNT(*) as total FROM ${this.table}`;
    if (where) sql += ` WHERE ${where}`;
    const [rows] = await this.pool.execute(sql, params);
    return rows[0].total;
  }

  async create(data) {
    const keys = Object.keys(data);
    const values = Object.values(data);
    const placeholders = keys.map(() => '?').join(', ');
    const [result] = await this.pool.execute(
      `INSERT INTO ${this.table} (${keys.join(', ')}) VALUES (${placeholders})`,
      values
    );
    return this.findById(result.insertId);
  }

  async update(id, data) {
    const keys = Object.keys(data);
    const values = Object.values(data);
    const setClause = keys.map((k) => `${k} = ?`).join(', ');
    await this.pool.execute(`UPDATE ${this.table} SET ${setClause} WHERE id = ?`, [...values, id]);
    return this.findById(id);
  }

  async delete(id) {
    const [result] = await this.pool.execute(`DELETE FROM ${this.table} WHERE id = ?`, [id]);
    return result.affectedRows > 0;
  }
}
