-- Flux Corp: Careers Table
CREATE TABLE IF NOT EXISTS careers (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(200) NOT NULL,
  slug VARCHAR(200) NOT NULL UNIQUE,
  department VARCHAR(100),
  location VARCHAR(200),
  employment_type ENUM('full-time', 'part-time', 'contract', 'internship') DEFAULT 'full-time',
  experience VARCHAR(50),
  description LONGTEXT,
  requirements LONGTEXT,
  benefits TEXT,
  salary_range VARCHAR(100),
  is_active TINYINT(1) DEFAULT 1,
  posted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  expires_at TIMESTAMP NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_careers_slug (slug),
  INDEX idx_careers_active (is_active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO careers (title, slug, department, location, employment_type, experience, description, requirements) VALUES
('Senior Design Engineer', 'senior-design-engineer', 'Engineering Design', 'Chakan, Pune', 'full-time', '5-8 years', 'Lead engineering design projects for automotive and railway clients.', 'BE/BTech in Mechanical/Automobile, CATIA/NX proficiency, 5+ years experience'),
('Composite Engineer', 'composite-engineer', 'Composites', 'Chikhali, Pune', 'full-time', '3-5 years', 'Develop composite solutions for bus body and industrial applications.', 'BE/BTech in Materials/Mechanical, FRP experience, hand layup and RTM knowledge'),
('CAD Designer - Automotive Styling', 'cad-designer-automotive', 'Automotive Styling', 'Chakan, Pune', 'full-time', '2-4 years', 'Create CAS models and Class A surfaces for automotive projects.', 'Diploma/BE in Design, Alias/ICEM Surf proficiency'),
('Production Manager', 'production-manager', 'Manufacturing', 'Chikhali, Pune', 'full-time', '8-12 years', 'Oversee bus body manufacturing operations and production planning.', 'BE/BTech in Mechanical/Production, 8+ years manufacturing experience'),
('Business Development Executive', 'business-development-executive', 'Sales', 'Pune', 'full-time', '3-5 years', 'Drive new business development in automotive and railway sectors.', 'MBA/BTech, excellent communication, B2B sales experience');
