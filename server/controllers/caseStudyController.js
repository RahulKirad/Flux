import caseStudyRepository from '../repositories/caseStudyRepository.js';

export const getCaseStudies = async (req, res) => {
  const caseStudies = await caseStudyRepository.findAllPublic(req.query);
  res.json({ success: true, data: caseStudies });
};

export const getCaseStudyBySlug = async (req, res) => {
  const caseStudy = await caseStudyRepository.findBySlug(req.params.slug);
  if (!caseStudy) return res.status(404).json({ success: false, message: 'Case study not found' });
  res.json({ success: true, data: caseStudy });
};

export const createCaseStudy = async (req, res) => {
  const caseStudy = await caseStudyRepository.create(req.body);
  res.status(201).json({ success: true, data: caseStudy });
};

export const updateCaseStudy = async (req, res) => {
  const caseStudy = await caseStudyRepository.update(req.params.id, req.body);
  res.json({ success: true, data: caseStudy });
};

export const deleteCaseStudy = async (req, res) => {
  await caseStudyRepository.delete(req.params.id);
  res.json({ success: true, message: 'Case study deleted' });
};
