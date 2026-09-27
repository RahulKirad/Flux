import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';
import userRepository from '../repositories/userRepository.js';

class AuthService {
  async login(email, password) {
    const user = await userRepository.findByLogin(email);
    if (!user) throw { statusCode: 401, message: 'Invalid credentials' };

    const isValid = await bcrypt.compare(password, user.password);
    if (!isValid) throw { statusCode: 401, message: 'Invalid credentials' };

    if (!user.is_active) throw { statusCode: 403, message: 'Account is deactivated' };

    const token = jwt.sign(
      { userId: user.id, role: user.role_slug },
      process.env.JWT_SECRET,
      { expiresIn: process.env.JWT_EXPIRES_IN || '7d' }
    );

    await userRepository.update(user.id, { last_login: new Date() });

    const { password: _, ...userWithoutPassword } = user;
    return { token, user: userWithoutPassword };
  }

  async register(data) {
    const existing = await userRepository.findByEmail(data.email);
    if (existing) throw { statusCode: 409, message: 'Email already registered' };

    const hashedPassword = await bcrypt.hash(data.password, 10);
    const user = await userRepository.create({
      ...data,
      password: hashedPassword,
      role_id: data.role_id || 3,
    });

    const { password: _, ...userWithoutPassword } = user;
    return userWithoutPassword;
  }

  async changePassword(userId, currentPassword, newPassword) {
    const user = await userRepository.findById(userId);
    const isValid = await bcrypt.compare(currentPassword, user.password);
    if (!isValid) throw { statusCode: 400, message: 'Current password is incorrect' };

    const hashedPassword = await bcrypt.hash(newPassword, 10);
    await userRepository.update(userId, { password: hashedPassword });
    return { message: 'Password updated successfully' };
  }
}

export default new AuthService();
