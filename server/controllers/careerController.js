import { careerRepository, applicationRepository } from '../repositories/careerRepository.js';

export const getCareers = async (_req, res) => {
  const careers = await careerRepository.findAllActive();
  res.json({ success: true, data: careers });
};

export const getCareerBySlug = async (req, res) => {
  const career = await careerRepository.findBySlug(req.params.slug);
  if (!career) return res.status(404).json({ success: false, message: 'Job not found' });
  res.json({ success: true, data: career });
};

export const applyForJob = async (req, res) => {
  const data = {
    career_id: req.params.id,
    name: req.body.name,
    email: req.body.email,
    phone: req.body.phone,
    cover_letter: req.body.cover_letter,
    experience_years: req.body.experience_years,
    current_company: req.body.current_company,
    resume_url: req.file ? `/uploads/resumes/${req.file.filename}` : req.body.resume_url,
  };
  const application = await applicationRepository.create(data);
  res.status(201).json({ success: true, data: application, message: 'Application submitted successfully' });
};

export const createCareer = async (req, res) => {
  const career = await careerRepository.create(req.body);
  res.status(201).json({ success: true, data: career });
};

export const updateCareer = async (req, res) => {
  const career = await careerRepository.update(req.params.id, req.body);
  res.json({ success: true, data: career });
};

export const deleteCareer = async (req, res) => {
  await careerRepository.delete(req.params.id);
  res.json({ success: true, message: 'Career deleted' });
};

export const getApplications = async (req, res) => {
  const applications = req.params.id
    ? await applicationRepository.findByCareer(req.params.id)
    : await applicationRepository.findAll({ orderBy: 'created_at DESC' });
  res.json({ success: true, data: applications });
};

export const updateApplicationStatus = async (req, res) => {
  const application = await applicationRepository.update(req.params.id, {
    status: req.body.status,
    notes: req.body.notes,
  });
  res.json({ success: true, data: application });
};
