import certificationRepository from '../repositories/certificationRepository.js';

export const getCertifications = async (_req, res) => {
  const certifications = await certificationRepository.findAllActive();
  res.json({ success: true, data: certifications });
};

export const createCertification = async (req, res) => {
  const cert = await certificationRepository.create(req.body);
  res.status(201).json({ success: true, data: cert });
};

export const updateCertification = async (req, res) => {
  const cert = await certificationRepository.update(req.params.id, req.body);
  res.json({ success: true, data: cert });
};

export const deleteCertification = async (req, res) => {
  await certificationRepository.delete(req.params.id);
  res.json({ success: true, message: 'Certification deleted' });
};
