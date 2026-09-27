-- Flux Corp: Roles Table
CREATE TABLE IF NOT EXISTS roles (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50) NOT NULL UNIQUE,
  slug VARCHAR(50) NOT NULL UNIQUE,
  description TEXT,
  permissions JSON,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_roles_slug (slug)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Seed Data
INSERT INTO roles (name, slug, description, permissions) VALUES
('Super Admin', 'super_admin', 'Full system access', '["*"]'),
('Admin', 'admin', 'Administrative access', '["dashboard","users","content","leads","media","settings"]'),
('Content Manager', 'content_manager', 'Manage website content', '["dashboard","services","projects","blogs","case_studies","certifications","facilities","media"]'),
('Sales Team', 'sales_team', 'Lead and inquiry management', '["dashboard","leads","inquiries","careers"]');
