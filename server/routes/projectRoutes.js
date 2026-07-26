import { Router } from 'express';
import * as ctrl from '../controllers/projectController.js';
import { authenticate, authorize } from '../middleware/auth.js';
import { asyncHandler } from '../middleware/errorHandler.js';

const router = Router();

router.get('/', asyncHandler(ctrl.getProjects));
router.get('/:slug', asyncHandler(ctrl.getProjectBySlug));
router.post('/', authenticate, authorize('super_admin', 'admin', 'content_manager'), asyncHandler(ctrl.createProject));
router.put('/:id', authenticate, authorize('super_admin', 'admin', 'content_manager'), asyncHandler(ctrl.updateProject));
router.delete('/:id', authenticate, authorize('super_admin', 'admin'), asyncHandler(ctrl.deleteProject));
router.post('/:id/gallery', authenticate, authorize('super_admin', 'admin', 'content_manager'), asyncHandler(ctrl.addGalleryItem));

export default router;
