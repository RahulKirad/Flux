import { Router } from 'express';
import * as ctrl from '../controllers/blogController.js';
import { authenticate, authorize } from '../middleware/auth.js';
import { asyncHandler } from '../middleware/errorHandler.js';

const router = Router();

router.get('/', asyncHandler(ctrl.getBlogs));
router.get('/categories', asyncHandler(ctrl.getBlogCategories));
router.get('/admin/all', authenticate, authorize('super_admin', 'admin', 'content_manager'), asyncHandler(ctrl.getAllBlogsAdmin));
router.get('/:slug', asyncHandler(ctrl.getBlogBySlug));
router.post('/', authenticate, authorize('super_admin', 'admin', 'content_manager'), asyncHandler(ctrl.createBlog));
router.put('/:id', authenticate, authorize('super_admin', 'admin', 'content_manager'), asyncHandler(ctrl.updateBlog));
router.delete('/:id', authenticate, authorize('super_admin', 'admin'), asyncHandler(ctrl.deleteBlog));

export default router;
