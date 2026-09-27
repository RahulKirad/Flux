-- Flux Corp: Projects Table
CREATE TABLE IF NOT EXISTS projects (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(300) NOT NULL,
  slug VARCHAR(300) NOT NULL UNIQUE,
  industry_id INT,
  service_id INT,
  category VARCHAR(100),
  client_name VARCHAR(200),
  banner VARCHAR(255),
  short_description TEXT,
  description LONGTEXT,
  challenge LONGTEXT,
  solution LONGTEXT,
  technologies JSON,
  results LONGTEXT,
  pdf_url VARCHAR(255),
  completion_date DATE,
  is_featured TINYINT(1) DEFAULT 0,
  is_active TINYINT(1) DEFAULT 1,
  meta_title VARCHAR(200),
  meta_description TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (industry_id) REFERENCES industries(id) ON DELETE SET NULL,
  FOREIGN KEY (service_id) REFERENCES services(id) ON DELETE SET NULL,
  INDEX idx_projects_slug (slug),
  INDEX idx_projects_industry (industry_id),
  INDEX idx_projects_category (category),
  INDEX idx_projects_featured (is_featured)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO projects (title, slug, industry_id, service_id, category, client_name, short_description, challenge, solution, results, is_featured) VALUES
('Electric Bus Body Platform', 'electric-bus-body-platform', 2, 6, 'Bus Manufacturing', 'Leading EV OEM', 'Complete electric bus body design and manufacturing for urban transit.', 'Design a lightweight, crash-compliant bus body structure for electric platform with modular assembly.', 'Developed composite-aluminium hybrid structure with integrated battery mounting and modular panel system.', '30% weight reduction, 15% improved energy efficiency, RDSO compliance achieved.', 1),
('Railway Coach Interior Module', 'railway-coach-interior-module', 4, 7, 'Railway', 'Indian Railways Partner', 'Modular interior systems for premium railway coaches.', 'Create fire-retardant, lightweight interior modules meeting RDSO fire safety standards.', 'Engineered FRP composite panels with integrated HVAC ducting and modular fit-out system.', 'Reduced installation time by 40%, full RDSO certification obtained.', 1),
('Automotive Class A Surfacing', 'automotive-class-a-surfacing', 1, 5, 'Automotive Styling', 'Global Automotive OEM', 'Production-ready Class A surfaces for new SUV platform.', 'Deliver photorealistic Class A surfaces with 0.1mm tolerance for production tooling.', 'Completed full exterior surfacing with VR validation and tooling-ready data delivery.', 'Tooling released 2 weeks ahead of schedule, zero rework required.', 1),
('Industrial Conveyor Enclosure', 'industrial-conveyor-enclosure', 5, 8, 'Industrial', 'Material Handling Corp', 'Custom enclosure system for automated conveyor line.', 'Design modular, maintainable enclosures for harsh industrial environment.', 'Developed snap-fit composite panels with integrated access panels and cable management.', 'Installation time reduced by 50%, maintenance access improved significantly.', 0),
('Composite Tooling for EV Battery Tray', 'composite-tooling-ev-battery', 3, 4, 'Tool & Die', 'EV Startup', 'Production tooling for composite battery enclosure.', 'Develop cost-effective tooling for high-volume composite battery tray production.', 'Designed and built epoxy-aluminium hybrid tooling with 500+ cycle capability.', 'Tooling cost 35% below target, first article approved on first try.', 1);
