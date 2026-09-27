-- Flux Corp: Case Studies Table
CREATE TABLE IF NOT EXISTS case_studies (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(300) NOT NULL,
  slug VARCHAR(300) NOT NULL UNIQUE,
  industry_id INT,
  service_id INT,
  banner VARCHAR(255),
  challenge LONGTEXT,
  solution LONGTEXT,
  outcome LONGTEXT,
  pdf_url VARCHAR(255),
  is_featured TINYINT(1) DEFAULT 0,
  is_active TINYINT(1) DEFAULT 1,
  meta_title VARCHAR(200),
  meta_description TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (industry_id) REFERENCES industries(id) ON DELETE SET NULL,
  FOREIGN KEY (service_id) REFERENCES services(id) ON DELETE SET NULL,
  INDEX idx_case_studies_slug (slug),
  INDEX idx_case_studies_featured (is_featured)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO case_studies (title, slug, industry_id, service_id, challenge, solution, outcome, is_featured) VALUES
('Lightweight Bus Structure Innovation', 'lightweight-bus-structure', 2, 6, 'A major bus OEM needed to reduce body weight by 25% while maintaining crash safety standards.', 'Flux Corp developed a hybrid aluminium-composite structure with optimized load paths and modular assembly.', 'Achieved 30% weight reduction, passed all crash tests, and reduced assembly time by 20%.', 1),
('RDSO Railway Component Certification', 'rdso-railway-certification', 4, 7, 'New supplier needed RDSO approval for composite interior panels within 6 months.', 'Complete design, testing, and documentation package delivered with in-house testing coordination.', 'Full RDSO certification achieved in 5 months, now supplying to 3 railway zones.', 1),
('Rapid EV Prototype Development', 'rapid-ev-prototype', 3, 3, 'EV startup required driveable prototype in 8 weeks for investor demo.', 'Parallel development using 3D printing, CNC machining, and composite hand layup.', 'Driveable prototype delivered in 7 weeks, securing Series A funding.', 1);
