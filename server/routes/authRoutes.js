import { Router } from 'express';
import { body } from 'express-validator';
import { login, register, getProfile, changePassword } from '../controllers/authController.js';
import { authenticate, authorize } from '../middleware/auth.js';
import { validate } from '../middleware/validate.js';
import { asyncHandler } from '../middleware/errorHandler.js';

const router = Router();

router.post('/login', [
  body('email').isEmail().normalizeEmail(),
  body('password').notEmpty(),
  validate,
], asyncHandler(login));

router.post('/register', authenticate, authorize('super_admin', 'admin'), [
  body('name').notEmpty().trim(),
  body('email').isEmail().normalizeEmail(),
  body('password').isLength({ min: 8 }),
  body('role_id').isInt(),
  validate,
], asyncHandler(register));

router.get('/profile', authenticate, asyncHandler(getProfile));
router.put('/change-password', authenticate, asyncHandler(changePassword));

export default router;
