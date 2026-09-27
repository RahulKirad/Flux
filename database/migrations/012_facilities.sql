-- Flux Corp: Facilities Table
CREATE TABLE IF NOT EXISTS facilities (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(200) NOT NULL,
  slug VARCHAR(200) NOT NULL UNIQUE,
  location VARCHAR(300),
  address TEXT,
  description LONGTEXT,
  capacity_details JSON,
  machinery_listing JSON,
  banner VARCHAR(255),
  video_url VARCHAR(500),
  latitude DECIMAL(10, 8),
  longitude DECIMAL(11, 8),
  sort_order INT DEFAULT 0,
  is_active TINYINT(1) DEFAULT 1,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_facilities_slug (slug)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO facilities (name, slug, location, address, description, capacity_details, machinery_listing, sort_order) VALUES
('Chikhali Facility', 'chikhali-facility', 'Chikhali, Pune, Maharashtra', 'Plot No. 45, MIDC Chikhali, Pune - 411062', 'Our primary manufacturing facility specializing in bus body manufacturing, composite forming, and large-scale assembly operations.', '{"area_sqft": 75000, "production_lines": 4, "monthly_capacity": "50 bus bodies"}', '["5-Axis CNC Router", "Vacuum Forming Machine", "FRP Layup Station", "Paint Booth", "Assembly Line"]', 1),
('Chakan Facility', 'chakan-facility', 'Chakan, Pune, Maharashtra', 'Survey No. 128, Chakan MIDC, Pune - 410501', 'Engineering design center and precision prototyping facility with advanced CAD/CAM capabilities.', '{"area_sqft": 35000, "design_stations": 30, "prototyping_cells": 3}', '["3D Printers (SLA/FDM)", "5-Axis CNC Machining Center", "CMM Machine", "VR Design Review Room", "Vacuum Casting Unit"]', 2);
