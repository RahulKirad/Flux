import { Router } from 'express';
import * as ctrl from '../controllers/serviceController.js';
import { authenticate, authorize } from '../middleware/auth.js';
import { asyncHandler } from '../middleware/errorHandler.js';

const router = Router();

router.get('/', asyncHandler(ctrl.getServices));
router.get('/:slug', asyncHandler(ctrl.getServiceBySlug));
router.post('/', authenticate, authorize('super_admin', 'admin', 'content_manager'), asyncHandler(ctrl.createService));
router.put('/:id', authenticate, authorize('super_admin', 'admin', 'content_manager'), asyncHandler(ctrl.updateService));
router.delete('/:id', authenticate, authorize('super_admin', 'admin'), asyncHandler(ctrl.deleteService));

export default router;
