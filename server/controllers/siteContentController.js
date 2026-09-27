import siteContentService from '../services/siteContentService.js';

export const getPublicSiteContent = async (_req, res) => {
  const data = await siteContentService.getMerged();
  res.json({ success: true, data });
};

export const getAdminSiteContent = async (_req, res) => {
  const data = await siteContentService.getMerged();
  res.json({ success: true, data });
};

export const updateSiteContent = async (req, res) => {
  const data = await siteContentService.save(req.body || {});
  res.json({ success: true, data, message: 'Site content saved' });
};
