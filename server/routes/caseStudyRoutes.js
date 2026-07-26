import { Router } from 'express';
import * as ctrl from '../controllers/caseStudyController.js';
import { authenticate, authorize } from '../middleware/auth.js';
import { asyncHandler } from '../middleware/errorHandler.js';

const router = Router();

router.get('/', asyncHandler(ctrl.getCaseStudies));
router.get('/:slug', asyncHandler(ctrl.getCaseStudyBySlug));
router.post('/', authenticate, authorize('super_admin', 'admin', 'content_manager'), asyncHandler(ctrl.createCaseStudy));
router.put('/:id', authenticate, authorize('super_admin', 'admin', 'content_manager'), asyncHandler(ctrl.updateCaseStudy));
router.delete('/:id', authenticate, authorize('super_admin', 'admin'), asyncHandler(ctrl.deleteCaseStudy));

export default router;
