-- ============================================================
-- Flux Corp — Complete Database Schema & Seed Data
-- Import: mysql -u root -p < database/flux_corp.sql
-- ============================================================

CREATE DATABASE IF NOT EXISTS flux_corp
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE flux_corp;

SET FOREIGN_KEY_CHECKS = 0;

-- ============================================================
-- 1. ROLES
-- ============================================================
CREATE TABLE IF NOT EXISTS roles (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50) NOT NULL UNIQUE,
  slug VARCHAR(50) NOT NULL UNIQUE,
  description TEXT,
  permissions JSON,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_roles_slug (slug)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO roles (name, slug, description, permissions) VALUES
('Super Admin', 'super_admin', 'Full system access', '["*"]'),
('Admin', 'admin', 'Administrative access', '["dashboard","users","content","leads","media","settings"]'),
('Content Manager', 'content_manager', 'Manage website content', '["dashboard","services","projects","blogs","case_studies","certifications","facilities","media"]'),
('Sales Team', 'sales_team', 'Lead and inquiry management', '["dashboard","leads","inquiries","careers"]');

-- ============================================================
-- 2. USERS
-- ============================================================
CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  role_id INT NOT NULL,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(150) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  avatar VARCHAR(255),
  phone VARCHAR(20),
  is_active TINYINT(1) DEFAULT 1,
  last_login TIMESTAMP NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE RESTRICT,
  INDEX idx_users_email (email),
  INDEX idx_users_role (role_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Default password for all seed users: Admin@123
INSERT INTO users (role_id, name, email, password, phone) VALUES
(1, 'Super Admin', 'admin@fluxcorp.com', '$2a$10$aXpNTmpDQ1DBrER4/AzBzOUQeFi0yvI3Chp9TzUxTID1F9s8ErDKS', '+91-9876543210'),
(2, 'Admin User', 'admin.user@fluxcorp.com', '$2a$10$aXpNTmpDQ1DBrER4/AzBzOUQeFi0yvI3Chp9TzUxTID1F9s8ErDKS', '+91-9876543211'),
(3, 'Content Manager', 'content@fluxcorp.com', '$2a$10$aXpNTmpDQ1DBrER4/AzBzOUQeFi0yvI3Chp9TzUxTID1F9s8ErDKS', '+91-9876543212'),
(4, 'Sales Manager', 'sales@fluxcorp.com', '$2a$10$aXpNTmpDQ1DBrER4/AzBzOUQeFi0yvI3Chp9TzUxTID1F9s8ErDKS', '+91-9876543213');

-- ============================================================
-- 3. SERVICES
-- ============================================================
CREATE TABLE IF NOT EXISTS services (
  id INT AUTO_INCREMENT PRIMARY KEY,
  parent_id INT NULL,
  title VARCHAR(200) NOT NULL,
  slug VARCHAR(200) NOT NULL UNIQUE,
  banner VARCHAR(255),
  icon VARCHAR(100),
  short_description TEXT,
  description LONGTEXT,
  benefits JSON,
  process_flow JSON,
  technologies JSON,
  brochure_url VARCHAR(255),
  meta_title VARCHAR(200),
  meta_description TEXT,
  meta_keywords VARCHAR(500),
  sort_order INT DEFAULT 0,
  is_featured TINYINT(1) DEFAULT 0,
  is_active TINYINT(1) DEFAULT 1,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (parent_id) REFERENCES services(id) ON DELETE SET NULL,
  INDEX idx_services_slug (slug),
  INDEX idx_services_parent (parent_id),
  INDEX idx_services_featured (is_featured)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO services (parent_id, title, slug, short_description, description, is_featured, sort_order) VALUES
(NULL, 'Engineering Design', 'engineering-design', 'Comprehensive engineering design solutions from concept to production.', 'Flux Corp delivers end-to-end engineering design services including concept development, feasibility studies, functional analysis, and packaging design for automotive, railway, and industrial sectors.', 1, 1),
(NULL, 'Composites & Forming', 'composites-forming', 'Advanced composite solutions and vacuum forming capabilities.', 'Our composites division specializes in FRP solutions, vacuum forming, material qualification, and tool development for lightweight structural applications.', 1, 2),
(NULL, 'Prototyping', 'prototyping', 'Rapid prototyping from concept validation to production-ready models.', 'State-of-the-art prototyping facilities including 3D printing, CNC machining, vacuum casting, and hand layup for fast iteration cycles.', 1, 3),
(NULL, 'Tools & Die', 'tools-die', 'Precision tooling solutions for manufacturing excellence.', 'Expert tool development including wooden, epoxy, metal, and epoxy aluminium tools for composite and forming applications.', 1, 4),
(NULL, 'Automotive Styling', 'automotive-styling', 'World-class CAS modeling and Class A surfacing.', 'Complete automotive styling services from CAS modeling to Class A surfacing, exterior and interior styling, and VR simulation.', 1, 5),
(NULL, 'Bus Body Manufacturing', 'bus-body-manufacturing', 'Complete bus body design and manufacturing solutions.', 'End-to-end bus body manufacturing with expertise in structural design, composite panels, and assembly for commercial vehicle OEMs.', 1, 6),
(NULL, 'Railway Components', 'railway-components', 'RDSO-approved railway component engineering and manufacturing.', 'Certified railway component design and manufacturing meeting RDSO and RITES standards for rolling stock applications.', 1, 7),
(NULL, 'Industrial Components', 'industrial-components', 'Custom industrial component engineering and production.', 'Precision industrial components for material handling, packaging systems, and heavy equipment applications.', 1, 8);

INSERT INTO services (parent_id, title, slug, short_description, sort_order) VALUES
(1, 'Concept Development', 'concept-development', 'Early-stage concept design and ideation.', 1),
(1, 'Feasibility Studies', 'feasibility-studies', 'Technical and economic feasibility analysis.', 2),
(1, 'Functional Analysis', 'functional-analysis', 'Detailed functional requirement analysis.', 3),
(1, 'Kinematic Analysis', 'kinematic-analysis', 'Motion and mechanism analysis.', 4),
(1, 'Packaging Design', 'packaging-design', 'Space optimization and packaging studies.', 5),
(1, 'Tolerance Analysis', 'tolerance-analysis', 'GD&T and tolerance stack-up analysis.', 6),
(2, 'FRP Solutions', 'frp-solutions', 'Fiber reinforced plastic composite solutions.', 1),
(2, 'Vacuum Forming', 'vacuum-forming', 'Thermoforming and vacuum forming processes.', 2),
(2, 'Material Qualification', 'material-qualification', 'Composite material testing and qualification.', 3),
(2, 'Tool Development', 'composite-tool-development', 'Composite forming tool design and build.', 4),
(3, '3D Printing', '3d-printing', 'Additive manufacturing for rapid prototypes.', 1),
(3, 'CNC Machining', 'cnc-machining', 'Precision CNC machined prototypes.', 2),
(3, 'Vacuum Casting', 'vacuum-casting', 'Silicone mold vacuum casting.', 3),
(3, 'Hand Layup', 'hand-layup', 'Manual composite layup prototypes.', 4),
(4, 'Wooden Tools', 'wooden-tools', 'Master model and wooden tooling.', 1),
(4, 'Epoxy Tools', 'epoxy-tools', 'Epoxy composite tooling solutions.', 2),
(4, 'Metal Tools', 'metal-tools', 'Steel and aluminium production tooling.', 3),
(4, 'Epoxy Aluminium Tools', 'epoxy-aluminium-tools', 'Hybrid epoxy-aluminium tooling.', 4),
(5, 'CAS Modeling', 'cas-modeling', 'Computer Aided Styling modeling.', 1),
(5, 'Class A Surfacing', 'class-a-surfacing', 'Production-quality Class A surfaces.', 2),
(5, 'Exterior Styling', 'exterior-styling', 'Vehicle exterior design development.', 3),
(5, 'Interior Styling', 'interior-styling', 'Cabin and interior design.', 4),
(5, 'VR Simulation', 'vr-simulation', 'Virtual reality design review.', 5);

-- ============================================================
-- 4. INDUSTRIES
-- ============================================================
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

-- ============================================================
-- 5. PROJECTS
-- ============================================================
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

-- ============================================================
-- 6. PROJECT GALLERY
-- ============================================================
CREATE TABLE IF NOT EXISTS project_gallery (
  id INT AUTO_INCREMENT PRIMARY KEY,
  project_id INT NOT NULL,
  media_type ENUM('image', 'video') DEFAULT 'image',
  url VARCHAR(500) NOT NULL,
  caption VARCHAR(300),
  sort_order INT DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE,
  INDEX idx_project_gallery_project (project_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO project_gallery (project_id, media_type, url, caption, sort_order) VALUES
(1, 'image', '/uploads/projects/electric-bus-1.jpg', 'Electric bus body structure assembly', 1),
(1, 'image', '/uploads/projects/electric-bus-2.jpg', 'Composite panel manufacturing', 2),
(2, 'image', '/uploads/projects/railway-interior-1.jpg', 'Railway coach interior module', 1),
(3, 'image', '/uploads/projects/class-a-1.jpg', 'Class A surfacing workflow', 1),
(4, 'image', '/uploads/projects/conveyor-1.jpg', 'Industrial conveyor enclosure', 1),
(5, 'image', '/uploads/projects/battery-tray-1.jpg', 'EV battery tray tooling', 1);

-- ============================================================
-- 7. CASE STUDIES
-- ============================================================
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

-- ============================================================
-- 8. BLOG CATEGORIES
-- ============================================================
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

-- ============================================================
-- 9. BLOG TAGS
-- ============================================================
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

-- ============================================================
-- 10. BLOGS
-- ============================================================
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

-- ============================================================
-- 11. CERTIFICATIONS
-- ============================================================
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

-- ============================================================
-- 12. FACILITIES
-- ============================================================
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

-- ============================================================
-- 13. FACILITY GALLERY
-- ============================================================
CREATE TABLE IF NOT EXISTS facility_gallery (
  id INT AUTO_INCREMENT PRIMARY KEY,
  facility_id INT NOT NULL,
  media_type ENUM('image', 'video') DEFAULT 'image',
  url VARCHAR(500) NOT NULL,
  caption VARCHAR(300),
  sort_order INT DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (facility_id) REFERENCES facilities(id) ON DELETE CASCADE,
  INDEX idx_facility_gallery_facility (facility_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO facility_gallery (facility_id, media_type, url, caption, sort_order) VALUES
(1, 'image', '/uploads/facilities/chikhali-1.jpg', 'Chikhali manufacturing floor', 1),
(1, 'image', '/uploads/facilities/chikhali-2.jpg', 'Bus body assembly line', 2),
(1, 'video', '/uploads/facilities/chikhali-tour.mp4', 'Facility virtual tour', 3),
(2, 'image', '/uploads/facilities/chakan-1.jpg', 'Chakan design center', 1),
(2, 'image', '/uploads/facilities/chakan-2.jpg', 'Prototyping lab', 2);

-- ============================================================
-- 14. CAREERS
-- ============================================================
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

-- ============================================================
-- 15. APPLICATIONS
-- ============================================================
CREATE TABLE IF NOT EXISTS applications (
  id INT AUTO_INCREMENT PRIMARY KEY,
  career_id INT NOT NULL,
  name VARCHAR(150) NOT NULL,
  email VARCHAR(150) NOT NULL,
  phone VARCHAR(20),
  resume_url VARCHAR(500),
  cover_letter TEXT,
  experience_years INT,
  current_company VARCHAR(200),
  status ENUM('new', 'reviewing', 'shortlisted', 'interviewed', 'offered', 'rejected', 'hired') DEFAULT 'new',
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (career_id) REFERENCES careers(id) ON DELETE CASCADE,
  INDEX idx_applications_career (career_id),
  INDEX idx_applications_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 16. LEADS
-- ============================================================
CREATE TABLE IF NOT EXISTS leads (
  id INT AUTO_INCREMENT PRIMARY KEY,
  source ENUM('contact_form', 'quote_request', 'brochure_download', 'service_inquiry', 'other') NOT NULL,
  name VARCHAR(150) NOT NULL,
  email VARCHAR(150) NOT NULL,
  phone VARCHAR(20),
  company VARCHAR(200),
  service_id INT,
  message TEXT,
  status ENUM('new', 'contacted', 'qualified', 'proposal', 'negotiation', 'won', 'lost') DEFAULT 'new',
  assigned_to INT,
  follow_up_notes JSON,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (service_id) REFERENCES services(id) ON DELETE SET NULL,
  FOREIGN KEY (assigned_to) REFERENCES users(id) ON DELETE SET NULL,
  INDEX idx_leads_status (status),
  INDEX idx_leads_source (source),
  INDEX idx_leads_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO leads (source, name, email, phone, company, service_id, message, status) VALUES
('quote_request', 'Rajesh Kumar', 'rajesh@autotech.com', '+91-9876543210', 'AutoTech Industries', 1, 'Need engineering design support for new SUV platform.', 'new'),
('contact_form', 'Priya Sharma', 'priya@railcorp.in', '+91-9876543211', 'RailCorp India', 7, 'Interested in RDSO-certified railway component manufacturing.', 'contacted'),
('brochure_download', 'Amit Patel', 'amit@evstartup.com', '+91-9876543212', 'EV Startup Ltd', 3, 'Downloaded prototyping brochure. Looking for rapid EV prototype.', 'qualified');

-- ============================================================
-- 17. INQUIRIES
-- ============================================================
CREATE TABLE IF NOT EXISTS inquiries (
  id INT AUTO_INCREMENT PRIMARY KEY,
  type ENUM('general', 'service', 'project', 'career', 'partnership') DEFAULT 'general',
  name VARCHAR(150) NOT NULL,
  email VARCHAR(150) NOT NULL,
  phone VARCHAR(20),
  company VARCHAR(200),
  subject VARCHAR(300),
  message TEXT NOT NULL,
  reference_id INT,
  is_read TINYINT(1) DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX idx_inquiries_type (type),
  INDEX idx_inquiries_read (is_read)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO inquiries (type, name, email, phone, company, subject, message) VALUES
('general', 'Vikram Singh', 'vikram@heavyind.com', '+91-9876543213', 'Heavy Industries Ltd', 'Partnership Inquiry', 'We are interested in exploring a long-term partnership for industrial component manufacturing.'),
('service', 'Neha Gupta', 'neha@designstudio.com', '+91-9876543214', 'Design Studio', 'Automotive Styling Services', 'Looking for Class A surfacing support for our upcoming vehicle project.');

-- ============================================================
-- 18. SEO
-- ============================================================
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

-- ============================================================
-- 19. MEDIA LIBRARY
-- ============================================================
CREATE TABLE IF NOT EXISTS media_library (
  id INT AUTO_INCREMENT PRIMARY KEY,
  filename VARCHAR(255) NOT NULL,
  original_name VARCHAR(255),
  file_path VARCHAR(500) NOT NULL,
  file_type ENUM('image', 'video', 'document', 'other') NOT NULL,
  mime_type VARCHAR(100),
  file_size INT,
  alt_text VARCHAR(300),
  caption TEXT,
  folder VARCHAR(100) DEFAULT 'general',
  uploaded_by INT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (uploaded_by) REFERENCES users(id) ON DELETE SET NULL,
  INDEX idx_media_type (file_type),
  INDEX idx_media_folder (folder)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- 20. SETTINGS
-- ============================================================
CREATE TABLE IF NOT EXISTS settings (
  id INT AUTO_INCREMENT PRIMARY KEY,
  setting_key VARCHAR(100) NOT NULL UNIQUE,
  setting_value LONGTEXT,
  setting_group VARCHAR(50) DEFAULT 'general',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_settings_key (setting_key),
  INDEX idx_settings_group (setting_group)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO settings (setting_key, setting_value, setting_group) VALUES
('company_name', 'Flux Corp', 'company'),
('company_tagline', 'Engineering Excellence. Manufacturing Innovation.', 'company'),
('company_email', 'info@fluxcorp.com', 'company'),
('company_phone', '+91-20-12345678', 'company'),
('company_address', 'Plot No. 45, MIDC Chikhali, Pune - 411062, Maharashtra, India', 'company'),
('company_logo', '/uploads/logo/flux-corp-logo.png', 'company'),
('company_favicon', '/uploads/logo/favicon.ico', 'company'),
('vision', 'To be the most trusted engineering and manufacturing partner for automotive, railway, and industrial sectors globally.', 'company'),
('mission', 'Deliver innovative engineering solutions and world-class manufacturing through technology, quality, and customer-centric approach.', 'company'),
('core_values', '["Innovation", "Quality", "Integrity", "Customer Focus", "Sustainability", "Excellence"]', 'company'),
('social_linkedin', 'https://linkedin.com/company/fluxcorp', 'social'),
('social_twitter', 'https://twitter.com/fluxcorp', 'social'),
('social_youtube', 'https://youtube.com/fluxcorp', 'social'),
('stats_projects', '500+', 'statistics'),
('stats_clients', '150+', 'statistics'),
('stats_years', '15+', 'statistics'),
('stats_engineers', '200+', 'statistics'),
('google_maps_api_key', '', 'integrations'),
('smtp_host', '', 'email'),
('smtp_port', '587', 'email'),
('smtp_user', '', 'email'),
('smtp_from', 'noreply@fluxcorp.com', 'email');

SET FOREIGN_KEY_CHECKS = 1;

-- ============================================================
-- Done! 20 tables created with seed data.
-- Admin login: admin@fluxcorp.com / Admin@123
-- ============================================================
