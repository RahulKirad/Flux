import industryRepository from '../repositories/industryRepository.js';

export const getIndustries = async (req, res) => {
  const industries = await industryRepository.findAllActive();
  res.json({ success: true, data: industries });
};

export const getIndustryBySlug = async (req, res) => {
  const industry = await industryRepository.findBySlugWithDetails(req.params.slug);
  if (!industry) return res.status(404).json({ success: false, message: 'Industry not found' });
  res.json({ success: true, data: industry });
};

export const createIndustry = async (req, res) => {
  const industry = await industryRepository.create(req.body);
  res.status(201).json({ success: true, data: industry });
};

export const updateIndustry = async (req, res) => {
  const industry = await industryRepository.update(req.params.id, req.body);
  res.json({ success: true, data: industry });
};

export const deleteIndustry = async (req, res) => {
  await industryRepository.delete(req.params.id);
  res.json({ success: true, message: 'Industry deleted' });
};
