import serviceRepository from '../repositories/serviceRepository.js';

export const getServices = async (req, res) => {
  const services = req.query.main === 'true'
    ? await serviceRepository.findMainServices()
    : await serviceRepository.findAllActive();
  res.json({ success: true, data: services });
};

export const getServiceBySlug = async (req, res) => {
  const service = await serviceRepository.findWithSubServices(req.params.slug);
  if (!service) return res.status(404).json({ success: false, message: 'Service not found' });
  res.json({ success: true, data: service });
};

export const createService = async (req, res) => {
  const service = await serviceRepository.create(req.body);
  res.status(201).json({ success: true, data: service });
};

export const updateService = async (req, res) => {
  const service = await serviceRepository.update(req.params.id, req.body);
  res.json({ success: true, data: service });
};

export const deleteService = async (req, res) => {
  await serviceRepository.delete(req.params.id);
  res.json({ success: true, message: 'Service deleted' });
};
