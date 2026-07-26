-- Flux Corp: Services Table
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

-- Seed Data: Main Services
INSERT INTO services (parent_id, title, slug, short_description, description, is_featured, sort_order) VALUES
(NULL, 'Engineering Design', 'engineering-design', 'Comprehensive engineering design solutions from concept to production.', 'Flux Corp delivers end-to-end engineering design services including concept development, feasibility studies, functional analysis, and packaging design for automotive, railway, and industrial sectors.', 1, 1),
(NULL, 'Composites & Forming', 'composites-forming', 'Advanced composite solutions and vacuum forming capabilities.', 'Our composites division specializes in FRP solutions, vacuum forming, material qualification, and tool development for lightweight structural applications.', 1, 2),
(NULL, 'Prototyping', 'prototyping', 'Rapid prototyping from concept validation to production-ready models.', 'State-of-the-art prototyping facilities including 3D printing, CNC machining, vacuum casting, and hand layup for fast iteration cycles.', 1, 3),
(NULL, 'Tools & Die', 'tools-die', 'Precision tooling solutions for manufacturing excellence.', 'Expert tool development including wooden, epoxy, metal, and epoxy aluminium tools for composite and forming applications.', 1, 4),
(NULL, 'Automotive Styling', 'automotive-styling', 'World-class CAS modeling and Class A surfacing.', 'Complete automotive styling services from CAS modeling to Class A surfacing, exterior and interior styling, and VR simulation.', 1, 5),
(NULL, 'Bus Body Manufacturing', 'bus-body-manufacturing', 'Complete bus body design and manufacturing solutions.', 'End-to-end bus body manufacturing with expertise in structural design, composite panels, and assembly for commercial vehicle OEMs.', 1, 6),
(NULL, 'Railway Components', 'railway-components', 'RDSO-approved railway component engineering and manufacturing.', 'Certified railway component design and manufacturing meeting RDSO and RITES standards for rolling stock applications.', 1, 7),
(NULL, 'Industrial Components', 'industrial-components', 'Custom industrial component engineering and production.', 'Precision industrial components for material handling, packaging systems, and heavy equipment applications.', 1, 8);

-- Sub-services: Engineering Design
INSERT INTO services (parent_id, title, slug, short_description, sort_order) VALUES
(1, 'Concept Development', 'concept-development', 'Early-stage concept design and ideation.', 1),
(1, 'Feasibility Studies', 'feasibility-studies', 'Technical and economic feasibility analysis.', 2),
(1, 'Functional Analysis', 'functional-analysis', 'Detailed functional requirement analysis.', 3),
(1, 'Kinematic Analysis', 'kinematic-analysis', 'Motion and mechanism analysis.', 4),
(1, 'Packaging Design', 'packaging-design', 'Space optimization and packaging studies.', 5),
(1, 'Tolerance Analysis', 'tolerance-analysis', 'GD&T and tolerance stack-up analysis.', 6);

-- Sub-services: Composites & Forming
INSERT INTO services (parent_id, title, slug, short_description, sort_order) VALUES
(2, 'FRP Solutions', 'frp-solutions', 'Fiber reinforced plastic composite solutions.', 1),
(2, 'Vacuum Forming', 'vacuum-forming', 'Thermoforming and vacuum forming processes.', 2),
(2, 'Material Qualification', 'material-qualification', 'Composite material testing and qualification.', 3),
(2, 'Tool Development', 'composite-tool-development', 'Composite forming tool design and build.', 4);

-- Sub-services: Prototyping
INSERT INTO services (parent_id, title, slug, short_description, sort_order) VALUES
(3, '3D Printing', '3d-printing', 'Additive manufacturing for rapid prototypes.', 1),
(3, 'CNC Machining', 'cnc-machining', 'Precision CNC machined prototypes.', 2),
(3, 'Vacuum Casting', 'vacuum-casting', 'Silicone mold vacuum casting.', 3),
(3, 'Hand Layup', 'hand-layup', 'Manual composite layup prototypes.', 4);

-- Sub-services: Tools & Die
INSERT INTO services (parent_id, title, slug, short_description, sort_order) VALUES
(4, 'Wooden Tools', 'wooden-tools', 'Master model and wooden tooling.', 1),
(4, 'Epoxy Tools', 'epoxy-tools', 'Epoxy composite tooling solutions.', 2),
(4, 'Metal Tools', 'metal-tools', 'Steel and aluminium production tooling.', 3),
(4, 'Epoxy Aluminium Tools', 'epoxy-aluminium-tools', 'Hybrid epoxy-aluminium tooling.', 4);

-- Sub-services: Automotive Styling
INSERT INTO services (parent_id, title, slug, short_description, sort_order) VALUES
(5, 'CAS Modeling', 'cas-modeling', 'Computer Aided Styling modeling.', 1),
(5, 'Class A Surfacing', 'class-a-surfacing', 'Production-quality Class A surfaces.', 2),
(5, 'Exterior Styling', 'exterior-styling', 'Vehicle exterior design development.', 3),
(5, 'Interior Styling', 'interior-styling', 'Cabin and interior design.', 4),
(5, 'VR Simulation', 'vr-simulation', 'Virtual reality design review.', 5);
