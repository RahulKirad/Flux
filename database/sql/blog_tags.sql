-- Flux Corp: Blog Tags Table
CREATE TABLE IF NOT EXISTS blog_tags (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  slug VARCHAR(50) NOT NULL UNIQUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_blog_tags_slug (slug)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO blog_tags (name, slug) VALUES
('Innovation', 'innovation'),
('Lightweighting', 'lightweighting'),
('RDSO', 'rdso'),
('EV', 'ev'),
('Composite', 'composite'),
('Automation', 'automation'),
('Quality', 'quality'),
('Sustainability', 'sustainability');
