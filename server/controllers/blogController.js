import blogRepository from '../repositories/blogRepository.js';
import pool from '../config/database.js';

export const getBlogs = async (req, res) => {
  const blogs = await blogRepository.findPublished(req.query);
  res.json({ success: true, data: blogs });
};

export const getBlogBySlug = async (req, res) => {
  const blog = await blogRepository.findBySlugPublished(req.params.slug);
  if (!blog) return res.status(404).json({ success: false, message: 'Blog not found' });
  res.json({ success: true, data: blog });
};

export const getBlogCategories = async (_req, res) => {
  const [categories] = await pool.execute('SELECT * FROM blog_categories ORDER BY name ASC');
  res.json({ success: true, data: categories });
};

export const createBlog = async (req, res) => {
  const data = { ...req.body, author_id: req.user.id };
  if (data.is_published) data.published_at = new Date();
  const blog = await blogRepository.create(data);
  res.status(201).json({ success: true, data: blog });
};

export const updateBlog = async (req, res) => {
  const blog = await blogRepository.update(req.params.id, req.body);
  res.json({ success: true, data: blog });
};

export const deleteBlog = async (req, res) => {
  await blogRepository.delete(req.params.id);
  res.json({ success: true, message: 'Blog deleted' });
};

export const getAllBlogsAdmin = async (_req, res) => {
  const blogs = await blogRepository.findAll({ orderBy: 'created_at DESC' });
  res.json({ success: true, data: blogs });
};
