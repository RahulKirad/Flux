import jwt from 'jsonwebtoken';
import pool from '../config/database.js';

export const authenticate = async (req, res, next) => {
  try {
    const authHeader = req.headers.authorization;
    if (!authHeader?.startsWith('Bearer ')) {
      return res.status(401).json({ success: false, message: 'Access token required' });
    }

    const token = authHeader.split(' ')[1];
    const decoded = jwt.verify(token, process.env.JWT_SECRET);

    const [users] = await pool.execute(
      `SELECT u.id, u.name, u.email, u.role_id, u.is_active, r.slug as role_slug, r.permissions
       FROM users u JOIN roles r ON u.role_id = r.id WHERE u.id = ?`,
      [decoded.userId]
    );

    if (!users.length || !users[0].is_active) {
      return res.status(401).json({ success: false, message: 'Invalid or inactive user' });
    }

    req.user = {
      ...users[0],
      permissions: typeof users[0].permissions === 'string'
        ? JSON.parse(users[0].permissions)
        : users[0].permissions,
    };
    next();
  } catch {
    return res.status(401).json({ success: false, message: 'Invalid or expired token' });
  }
};

export const authorize = (...allowedRoles) => {
  return (req, res, next) => {
    if (!req.user) {
      return res.status(401).json({ success: false, message: 'Authentication required' });
    }

    if (req.user.permissions?.includes('*') || allowedRoles.includes(req.user.role_slug)) {
      return next();
    }

    return res.status(403).json({ success: false, message: 'Insufficient permissions' });
  };
};

export const optionalAuth = async (req, res, next) => {
  try {
    const authHeader = req.headers.authorization;
    if (authHeader?.startsWith('Bearer ')) {
      const token = authHeader.split(' ')[1];
      const decoded = jwt.verify(token, process.env.JWT_SECRET);
      const [users] = await pool.execute(
        'SELECT u.id, u.name, u.email, u.role_id, r.slug as role_slug FROM users u JOIN roles r ON u.role_id = r.id WHERE u.id = ? AND u.is_active = 1',
        [decoded.userId]
      );
      if (users.length) req.user = users[0];
    }
  } catch {
    // Optional auth - continue without user
  }
  next();
};
