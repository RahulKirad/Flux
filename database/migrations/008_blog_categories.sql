-- Flux Corp: Blog Categories Table
CREATE TABLE IF NOT EXISTS blog_categories (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  slug VARCHAR(100) NOT NULL UNIQUE,
  description TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_blog_categories_slug (slug)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO blog_categories (name, slug, description) VALUES
('Engineering Design', 'engineering-design', 'Articles on engineering design methodologies and innovations.'),
('Bus Manufacturing', 'bus-manufacturing', 'Insights on bus body design and manufacturing.'),
('Railway Industry', 'railway-industry', 'Railway sector engineering and compliance updates.'),
('Composites', 'composites', 'Composite materials and forming technology.'),
('Prototyping', 'prototyping', 'Rapid prototyping techniques and case studies.'),
('Tool & Die', 'tool-die', 'Tooling design and manufacturing best practices.');
