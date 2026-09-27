-- Flux Corp: Certifications Table
CREATE TABLE IF NOT EXISTS certifications (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(200) NOT NULL,
  slug VARCHAR(200) NOT NULL UNIQUE,
  category VARCHAR(100) NOT NULL,
  description TEXT,
  certificate_image VARCHAR(255),
  pdf_url VARCHAR(255),
  issued_by VARCHAR(200),
  issued_date DATE,
  expiry_date DATE,
  sort_order INT DEFAULT 0,
  is_active TINYINT(1) DEFAULT 1,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_certifications_slug (slug),
  INDEX idx_certifications_category (category)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO certifications (title, slug, category, description, issued_by, issued_date, sort_order) VALUES
('ISO 9001:2015', 'iso-9001', 'ISO 9001', 'Quality Management System certification for design and manufacturing.', 'Bureau Veritas', '2022-03-15', 1),
('IATF 16949:2016', 'iatf-16949', 'IATF 16949', 'Automotive Quality Management System certification.', 'TÜV SÜD', '2023-06-01', 2),
('RDSO Approval', 'rdso-approval', 'RDSO', 'Research Designs and Standards Organisation approval for railway components.', 'RDSO Lucknow', '2021-09-20', 3),
('RITES Certification', 'rites-certification', 'RITES', 'Rail India Technical and Economic Service vendor certification.', 'RITES Ltd', '2022-11-10', 4),
('AIS 153 Compliance', 'ais-153-compliance', 'AIS 153', 'Automotive Industry Standard 153 compliance for bus body structures.', 'ARAI Pune', '2023-01-05', 5);
