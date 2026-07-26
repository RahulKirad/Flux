import { Router } from 'express';
import * as ctrl from '../controllers/mediaController.js';
import { authenticate, authorize } from '../middleware/auth.js';
import { upload, setUploadFolder } from '../middleware/upload.js';
import { asyncHandler } from '../middleware/errorHandler.js';

const router = Router();

router.get('/', authenticate, authorize('super_admin', 'admin', 'content_manager'), asyncHandler(ctrl.getMedia));
router.post('/upload', authenticate, authorize('super_admin', 'admin', 'content_manager'), setUploadFolder('general'), upload.single('file'), asyncHandler(ctrl.uploadMedia));
router.delete('/:id', authenticate, authorize('super_admin', 'admin'), asyncHandler(ctrl.deleteMedia));

export default router;
