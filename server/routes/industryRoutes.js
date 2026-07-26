import { Router } from 'express';
import * as ctrl from '../controllers/industryController.js';
import { authenticate, authorize } from '../middleware/auth.js';
import { asyncHandler } from '../middleware/errorHandler.js';

const router = Router();

router.get('/', asyncHandler(ctrl.getIndustries));
router.get('/:slug', asyncHandler(ctrl.getIndustryBySlug));
router.post('/', authenticate, authorize('super_admin', 'admin', 'content_manager'), asyncHandler(ctrl.createIndustry));
router.put('/:id', authenticate, authorize('super_admin', 'admin', 'content_manager'), asyncHandler(ctrl.updateIndustry));
router.delete('/:id', authenticate, authorize('super_admin', 'admin'), asyncHandler(ctrl.deleteIndustry));

export default router;
