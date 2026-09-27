import { Router } from 'express';
import * as ctrl from '../controllers/siteContentController.js';
import { authenticate, authorize } from '../middleware/auth.js';
import { asyncHandler } from '../middleware/errorHandler.js';

const router = Router();

router.get('/', asyncHandler(ctrl.getPublicSiteContent));
router.get('/admin', authenticate, authorize('super_admin', 'admin', 'content_manager'), asyncHandler(ctrl.getAdminSiteContent));
router.put('/', authenticate, authorize('super_admin', 'admin', 'content_manager'), asyncHandler(ctrl.updateSiteContent));

export default router;
