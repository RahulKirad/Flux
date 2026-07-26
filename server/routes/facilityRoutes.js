import { Router } from 'express';
import * as ctrl from '../controllers/facilityController.js';
import { authenticate, authorize } from '../middleware/auth.js';
import { asyncHandler } from '../middleware/errorHandler.js';

const router = Router();

router.get('/', asyncHandler(ctrl.getFacilities));
router.get('/:slug', asyncHandler(ctrl.getFacilityBySlug));
router.post('/', authenticate, authorize('super_admin', 'admin', 'content_manager'), asyncHandler(ctrl.createFacility));
router.put('/:id', authenticate, authorize('super_admin', 'admin', 'content_manager'), asyncHandler(ctrl.updateFacility));
router.delete('/:id', authenticate, authorize('super_admin', 'admin'), asyncHandler(ctrl.deleteFacility));
router.post('/:id/gallery', authenticate, authorize('super_admin', 'admin', 'content_manager'), asyncHandler(ctrl.addFacilityGallery));

export default router;
