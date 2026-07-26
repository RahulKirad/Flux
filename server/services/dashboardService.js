import pool from '../config/database.js';
import leadRepository from '../repositories/leadRepository.js';
import projectRepository from '../repositories/projectRepository.js';
import blogRepository from '../repositories/blogRepository.js';

class DashboardService {
  async getStats() {
    const leadStats = await leadRepository.getStats();

    const [[{ projectCount }]] = await pool.execute(
      'SELECT COUNT(*) as projectCount FROM projects WHERE is_active = 1'
    );
    const [[{ blogCount }]] = await pool.execute(
      'SELECT COUNT(*) as blogCount FROM blogs WHERE is_published = 1'
    );
    const [[{ inquiryCount }]] = await pool.execute(
      'SELECT COUNT(*) as inquiryCount FROM inquiries WHERE is_read = 0'
    );
    const [[{ applicationCount }]] = await pool.execute(
      "SELECT COUNT(*) as applicationCount FROM applications WHERE status = 'new'"
    );

    const [recentLeads] = await pool.execute(
      'SELECT id, name, email, source, status, created_at FROM leads ORDER BY created_at DESC LIMIT 5'
    );

    const [leadsByStatus] = await pool.execute(
      'SELECT status, COUNT(*) as count FROM leads GROUP BY status'
    );

    const [leadsByMonth] = await pool.execute(`
      SELECT DATE_FORMAT(created_at, '%Y-%m') as month, COUNT(*) as count
      FROM leads WHERE created_at >= DATE_SUB(NOW(), INTERVAL 6 MONTH)
      GROUP BY month ORDER BY month ASC
    `);

    return {
      leads: leadStats,
      projects: projectCount,
      blogs: blogCount,
      unreadInquiries: inquiryCount,
      newApplications: applicationCount,
      recentLeads,
      leadsByStatus,
      leadsByMonth,
    };
  }
}

export default new DashboardService();
