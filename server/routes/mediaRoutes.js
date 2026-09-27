import { Router } from 'express';
import * as ctrl from '../controllers/mediaController.js';
import { authenticate, authorize } from '../middleware/auth.js';
import { upload } from '../middleware/upload.js';
import { asyncHandler } from '../middleware/errorHandler.js';

const router = Router();

router.get('/', authenticate, authorize('super_admin', 'admin', 'content_manager'), asyncHandler(ctrl.getMedia));
router.post(
  '/upload',
  authenticate,
  authorize('super_admin', 'admin', 'content_manager'),
  (req, _res, next) => {
    const folder = typeof req.query.folder === 'string' && req.query.folder ? req.query.folder : 'general';
    req.uploadFolder = folder.replace(/[^a-z0-9_-]/gi, '') || 'general';
    next();
  },
  upload.single('file'),
  asyncHandler(ctrl.uploadMedia),
);
router.delete('/:id', authenticate, authorize('super_admin', 'admin'), asyncHandler(ctrl.deleteMedia));

export default router;
