import authService from '../services/authService.js';

export const login = async (req, res) => {
  const { email, password } = req.body;
  const result = await authService.login(email, password);
  res.json({ success: true, data: result });
};

export const register = async (req, res) => {
  const user = await authService.register(req.body);
  res.status(201).json({ success: true, data: user });
};

export const getProfile = async (req, res) => {
  res.json({ success: true, data: req.user });
};

export const changePassword = async (req, res) => {
  const { currentPassword, newPassword } = req.body;
  const result = await authService.changePassword(req.user.id, currentPassword, newPassword);
  res.json({ success: true, data: result });
};
