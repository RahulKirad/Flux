import { Router } from 'express';
import * as ctrl from '../controllers/careerController.js';
import { authenticate, authorize } from '../middleware/auth.js';
import { upload, setUploadFolder } from '../middleware/upload.js';
import { asyncHandler } from '../middleware/errorHandler.js';

const router = Router();

router.get('/', asyncHandler(ctrl.getCareers));
router.get('/applications/all', authenticate, authorize('super_admin', 'admin', 'sales_team'), asyncHandler(ctrl.getApplications));
router.get('/applications/:id', authenticate, authorize('super_admin', 'admin', 'sales_team'), asyncHandler(ctrl.getApplications));
router.put('/applications/:id', authenticate, authorize('super_admin', 'admin', 'sales_team'), asyncHandler(ctrl.updateApplicationStatus));
router.get('/:slug', asyncHandler(ctrl.getCareerBySlug));
router.post('/:id/apply', setUploadFolder('resumes'), upload.single('resume'), asyncHandler(ctrl.applyForJob));
router.post('/', authenticate, authorize('super_admin', 'admin', 'sales_team'), asyncHandler(ctrl.createCareer));
router.put('/:id', authenticate, authorize('super_admin', 'admin', 'sales_team'), asyncHandler(ctrl.updateCareer));
router.delete('/:id', authenticate, authorize('super_admin', 'admin'), asyncHandler(ctrl.deleteCareer));

export default router;
