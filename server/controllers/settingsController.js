import settingsRepository from '../repositories/settingsRepository.js';
import pool from '../config/database.js';
import dashboardService from '../services/dashboardService.js';
import userRepository from '../repositories/userRepository.js';

export const getSettings = async (_req, res) => {
  const settings = await settingsRepository.getAllGrouped();
  res.json({ success: true, data: settings });
};

export const getPublicSettings = async (_req, res) => {
  const settings = await settingsRepository.getAllGrouped();
  res.json({ success: true, data: settings });
};

export const updateSettings = async (req, res) => {
  const updates = req.body;
  for (const [key, value] of Object.entries(updates)) {
    await settingsRepository.upsert(key, value, req.body.group || 'general');
  }
  res.json({ success: true, message: 'Settings updated' });
};

export const getDashboard = async (_req, res) => {
  const stats = await dashboardService.getStats();
  res.json({ success: true, data: stats });
};

export const getUsers = async (_req, res) => {
  const users = await userRepository.findAllWithRole();
  res.json({ success: true, data: users });
};

export const createUser = async (req, res) => {
  const bcrypt = await import('bcryptjs');
  const hashedPassword = await bcrypt.default.hash(req.body.password, 10);
  const user = await userRepository.create({ ...req.body, password: hashedPassword });
  res.status(201).json({ success: true, data: user });
};

export const updateUser = async (req, res) => {
  const user = await userRepository.update(req.params.id, req.body);
  res.json({ success: true, data: user });
};

export const getSeo = async (req, res) => {
  const [rows] = await pool.execute(
    req.params.key
      ? 'SELECT * FROM seo WHERE page_key = ?'
      : 'SELECT * FROM seo ORDER BY page_key ASC',
    req.params.key ? [req.params.key] : []
  );
  res.json({ success: true, data: req.params.key ? rows[0] : rows });
};

export const updateSeo = async (req, res) => {
  const [existing] = await pool.execute('SELECT id FROM seo WHERE page_key = ?', [req.params.key]);
  if (existing.length) {
    const keys = Object.keys(req.body);
    await pool.execute(
      `UPDATE seo SET ${keys.map((k) => `${k} = ?`).join(', ')} WHERE page_key = ?`,
      [...Object.values(req.body), req.params.key]
    );
  } else {
    await pool.execute(
      'INSERT INTO seo (page_key, page_path, meta_title, meta_description, meta_keywords, og_title, og_description, og_image) VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
      [req.params.key, req.body.page_path, req.body.meta_title, req.body.meta_description, req.body.meta_keywords, req.body.og_title, req.body.og_description, req.body.og_image]
    );
  }
  res.json({ success: true, message: 'SEO updated' });
};
