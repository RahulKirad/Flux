import { Router } from 'express';
import * as ctrl from '../controllers/leadController.js';
import { authenticate, authorize } from '../middleware/auth.js';
import { asyncHandler } from '../middleware/errorHandler.js';

const router = Router();

router.post('/', asyncHandler(ctrl.createLead));
router.post('/inquiry', asyncHandler(ctrl.createInquiry));
router.get('/', authenticate, authorize('super_admin', 'admin', 'sales_team'), asyncHandler(ctrl.getLeads));
router.get('/export', authenticate, authorize('super_admin', 'admin', 'sales_team'), asyncHandler(ctrl.exportLeads));
router.get('/inquiries', authenticate, authorize('super_admin', 'admin', 'sales_team'), asyncHandler(ctrl.getInquiries));
router.put('/inquiries/:id/read', authenticate, authorize('super_admin', 'admin', 'sales_team'), asyncHandler(ctrl.markInquiryRead));
router.put('/:id', authenticate, authorize('super_admin', 'admin', 'sales_team'), asyncHandler(ctrl.updateLead));
router.post('/:id/follow-up', authenticate, authorize('super_admin', 'admin', 'sales_team'), asyncHandler(ctrl.addFollowUpNote));

export default router;
