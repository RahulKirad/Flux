import projectRepository from '../repositories/projectRepository.js';
import pool from '../config/database.js';

export const getProjects = async (req, res) => {
  const projects = await projectRepository.findAllPublic(req.query);
  const total = await projectRepository.count('is_active = 1');
  res.json({ success: true, data: projects, total });
};

export const getProjectBySlug = async (req, res) => {
  const project = await projectRepository.findBySlugWithDetails(req.params.slug);
  if (!project) return res.status(404).json({ success: false, message: 'Project not found' });
  res.json({ success: true, data: project });
};

export const createProject = async (req, res) => {
  const project = await projectRepository.create(req.body);
  res.status(201).json({ success: true, data: project });
};

export const updateProject = async (req, res) => {
  const project = await projectRepository.update(req.params.id, req.body);
  res.json({ success: true, data: project });
};

export const deleteProject = async (req, res) => {
  await projectRepository.delete(req.params.id);
  res.json({ success: true, message: 'Project deleted' });
};

export const addGalleryItem = async (req, res) => {
  const [result] = await pool.execute(
    'INSERT INTO project_gallery (project_id, media_type, url, caption, sort_order) VALUES (?, ?, ?, ?, ?)',
    [req.params.id, req.body.media_type || 'image', req.body.url, req.body.caption, req.body.sort_order || 0]
  );
  res.status(201).json({ success: true, data: { id: result.insertId } });
};
