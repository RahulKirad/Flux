import { Router } from 'express';
import * as ctrl from '../controllers/certificationController.js';
import { authenticate, authorize } from '../middleware/auth.js';
import { asyncHandler } from '../middleware/errorHandler.js';

const router = Router();

router.get('/', asyncHandler(ctrl.getCertifications));
router.post('/', authenticate, authorize('super_admin', 'admin', 'content_manager'), asyncHandler(ctrl.createCertification));
router.put('/:id', authenticate, authorize('super_admin', 'admin', 'content_manager'), asyncHandler(ctrl.updateCertification));
router.delete('/:id', authenticate, authorize('super_admin', 'admin'), asyncHandler(ctrl.deleteCertification));

export default router;
