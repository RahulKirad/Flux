-- Flux Corp: Blogs Table
CREATE TABLE IF NOT EXISTS blogs (
  id INT AUTO_INCREMENT PRIMARY KEY,
  category_id INT,
  author_id INT,
  title VARCHAR(300) NOT NULL,
  slug VARCHAR(300) NOT NULL UNIQUE,
  banner VARCHAR(255),
  excerpt TEXT,
  content LONGTEXT,
  tags JSON,
  read_time INT DEFAULT 5,
  views INT DEFAULT 0,
  is_featured TINYINT(1) DEFAULT 0,
  is_published TINYINT(1) DEFAULT 0,
  published_at TIMESTAMP NULL,
  meta_title VARCHAR(200),
  meta_description TEXT,
  meta_keywords VARCHAR(500),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (category_id) REFERENCES blog_categories(id) ON DELETE SET NULL,
  FOREIGN KEY (author_id) REFERENCES users(id) ON DELETE SET NULL,
  INDEX idx_blogs_slug (slug),
  INDEX idx_blogs_category (category_id),
  INDEX idx_blogs_published (is_published, published_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO blogs (category_id, author_id, title, slug, excerpt, content, tags, read_time, is_featured, is_published, published_at) VALUES
(1, 1, 'The Future of Engineering Design in India', 'future-engineering-design-india', 'How Indian engineering companies are leveraging digital tools to compete globally.', '<p>Engineering design in India is undergoing a transformative shift...</p>', '["innovation", "automation"]', 8, 1, 1, NOW()),
(2, 1, 'Composite Materials Revolutionizing Bus Manufacturing', 'composites-bus-manufacturing', 'Lightweight composites are changing the bus body manufacturing landscape.', '<p>The commercial vehicle industry is embracing composite materials...</p>', '["composite", "lightweighting"]', 6, 1, 1, NOW()),
(3, 1, 'RDSO Compliance: A Complete Guide for Suppliers', 'rdso-compliance-guide', 'Everything you need to know about RDSO certification for railway components.', '<p>RDSO certification is essential for railway component suppliers...</p>', '["rdso", "quality"]', 10, 0, 1, NOW()),
(4, 1, 'Advanced Composite Forming Techniques', 'advanced-composite-forming', 'Exploring vacuum forming, RTM, and other composite manufacturing processes.', '<p>Composite forming has evolved significantly over the past decade...</p>', '["composite", "innovation"]', 7, 0, 1, NOW());
