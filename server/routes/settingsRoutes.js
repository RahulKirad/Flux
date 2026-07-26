import { Router } from 'express';
import * as ctrl from '../controllers/settingsController.js';
import { authenticate, authorize } from '../middleware/auth.js';
import { asyncHandler } from '../middleware/errorHandler.js';

const router = Router();

router.get('/public', asyncHandler(ctrl.getPublicSettings));
router.get('/dashboard', authenticate, asyncHandler(ctrl.getDashboard));
router.get('/', authenticate, authorize('super_admin', 'admin'), asyncHandler(ctrl.getSettings));
router.put('/', authenticate, authorize('super_admin', 'admin'), asyncHandler(ctrl.updateSettings));
router.get('/seo', asyncHandler(ctrl.getSeo));
router.get('/seo/:key', asyncHandler(ctrl.getSeo));
router.put('/seo/:key', authenticate, authorize('super_admin', 'admin', 'content_manager'), asyncHandler(ctrl.updateSeo));
router.get('/users', authenticate, authorize('super_admin', 'admin'), asyncHandler(ctrl.getUsers));
router.post('/users', authenticate, authorize('super_admin'), asyncHandler(ctrl.createUser));
router.put('/users/:id', authenticate, authorize('super_admin', 'admin'), asyncHandler(ctrl.updateUser));

export default router;
