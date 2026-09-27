-- Flux Corp: SEO Table
CREATE TABLE IF NOT EXISTS seo (
  id INT AUTO_INCREMENT PRIMARY KEY,
  page_key VARCHAR(100) NOT NULL UNIQUE,
  page_path VARCHAR(255),
  meta_title VARCHAR(200),
  meta_description TEXT,
  meta_keywords VARCHAR(500),
  og_title VARCHAR(200),
  og_description TEXT,
  og_image VARCHAR(255),
  canonical_url VARCHAR(500),
  robots VARCHAR(100) DEFAULT 'index, follow',
  structured_data JSON,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_seo_page_key (page_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO seo (page_key, page_path, meta_title, meta_description, meta_keywords) VALUES
('home', '/', 'Flux Corp | Engineering Design, Composites & Manufacturing', 'Flux Corp is a leading engineering company specializing in design, composites, prototyping, bus body manufacturing, and railway components in Pune, India.', 'engineering design, composites, bus manufacturing, railway components, Pune'),
('about', '/about', 'About Flux Corp | Engineering Excellence Since Inception', 'Learn about Flux Corp''s vision, mission, leadership team, and world-class manufacturing facilities in Chikhali and Chakan, Pune.', 'about flux corp, engineering company Pune, manufacturing facilities'),
('services', '/services', 'Our Services | Engineering Design to Manufacturing', 'Explore Flux Corp services: Engineering Design, Composites, Prototyping, Tools & Die, Automotive Styling, Bus Body, Railway Components.', 'engineering services, composite forming, prototyping, automotive styling'),
('projects', '/projects', 'Projects & Portfolio | Flux Corp Engineering', 'Browse Flux Corp project portfolio across automotive, railway, EV, and industrial sectors.', 'engineering projects, portfolio, case studies'),
('contact', '/contact', 'Contact Flux Corp | Get a Quote', 'Contact Flux Corp for engineering design, manufacturing, and prototyping inquiries. Offices in Chikhali and Chakan, Pune.', 'contact flux corp, quote request, Pune engineering');
