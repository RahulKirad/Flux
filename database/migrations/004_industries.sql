-- Flux Corp: Industries Table
CREATE TABLE IF NOT EXISTS industries (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(200) NOT NULL,
  slug VARCHAR(200) NOT NULL UNIQUE,
  banner VARCHAR(255),
  icon VARCHAR(100),
  short_description TEXT,
  description LONGTEXT,
  challenges JSON,
  solutions JSON,
  meta_title VARCHAR(200),
  meta_description TEXT,
  sort_order INT DEFAULT 0,
  is_active TINYINT(1) DEFAULT 1,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_industries_slug (slug)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO industries (title, slug, short_description, description, sort_order) VALUES
('Automotive', 'automotive', 'Passenger and commercial vehicle engineering solutions.', 'Flux Corp provides comprehensive automotive engineering services from styling and design to prototyping and production tooling for OEMs and tier suppliers.', 1),
('Commercial Vehicles', 'commercial-vehicles', 'Truck, bus, and specialty vehicle solutions.', 'Specialized engineering for commercial vehicle platforms including bus body manufacturing, chassis components, and fleet customization.', 2),
('Electric Vehicles', 'electric-vehicles', 'EV platform design and lightweighting solutions.', 'Advanced engineering for electric vehicle platforms focusing on battery enclosure design, lightweight composites, and thermal management.', 3),
('Railways', 'railways', 'RDSO-certified railway component manufacturing.', 'Certified railway component design and manufacturing for rolling stock, meeting stringent RDSO and RITES compliance requirements.', 4),
('Industrial Equipment', 'industrial-equipment', 'Heavy machinery and industrial component engineering.', 'Custom industrial equipment design and manufacturing for mining, construction, and process industries.', 5),
('Material Handling', 'material-handling', 'Conveyor, crane, and handling system components.', 'Engineering solutions for material handling equipment including structural components, enclosures, and operator cabins.', 6),
('Packaging Systems', 'packaging-systems', 'Automated packaging machinery components.', 'Precision components and enclosures for automated packaging and processing equipment.', 7);
