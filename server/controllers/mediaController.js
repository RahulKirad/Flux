import mediaRepository from '../repositories/mediaRepository.js';

export const getMedia = async (req, res) => {
  const media = req.query.type
    ? await mediaRepository.findByType(req.query.type, req.query)
    : await mediaRepository.findAll({ orderBy: 'created_at DESC', limit: req.query.limit || 50 });
  res.json({ success: true, data: media });
};

export const uploadMedia = async (req, res) => {
  if (!req.file) return res.status(400).json({ success: false, message: 'No file uploaded' });

  const fileType = req.file.mimetype.startsWith('image/') ? 'image'
    : req.file.mimetype.startsWith('video/') ? 'video'
    : req.file.mimetype === 'application/pdf' ? 'document' : 'other';

  const folder = req.uploadFolder || 'general';
  const media = await mediaRepository.create({
    filename: req.file.filename,
    original_name: req.file.originalname,
    file_path: `/uploads/${folder}/${req.file.filename}`,
    file_type: fileType,
    mime_type: req.file.mimetype,
    file_size: req.file.size,
    alt_text: req.body.alt_text || '',
    folder,
    uploaded_by: req.user?.id,
  });

  res.status(201).json({ success: true, data: media });
};

export const deleteMedia = async (req, res) => {
  await mediaRepository.delete(req.params.id);
  res.json({ success: true, message: 'Media deleted' });
};
