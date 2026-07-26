import facilityRepository from '../repositories/facilityRepository.js';
import pool from '../config/database.js';

export const getFacilities = async (_req, res) => {
  const facilities = await facilityRepository.findAllWithGallery();
  res.json({ success: true, data: facilities });
};

export const getFacilityBySlug = async (req, res) => {
  const facility = await facilityRepository.findBySlugWithGallery(req.params.slug);
  if (!facility) return res.status(404).json({ success: false, message: 'Facility not found' });
  res.json({ success: true, data: facility });
};

export const createFacility = async (req, res) => {
  const facility = await facilityRepository.create(req.body);
  res.status(201).json({ success: true, data: facility });
};

export const updateFacility = async (req, res) => {
  const facility = await facilityRepository.update(req.params.id, req.body);
  res.json({ success: true, data: facility });
};

export const deleteFacility = async (req, res) => {
  await facilityRepository.delete(req.params.id);
  res.json({ success: true, message: 'Facility deleted' });
};

export const addFacilityGallery = async (req, res) => {
  const [result] = await pool.execute(
    'INSERT INTO facility_gallery (facility_id, media_type, url, caption, sort_order) VALUES (?, ?, ?, ?, ?)',
    [req.params.id, req.body.media_type || 'image', req.body.url, req.body.caption, req.body.sort_order || 0]
  );
  res.status(201).json({ success: true, data: { id: result.insertId } });
};
