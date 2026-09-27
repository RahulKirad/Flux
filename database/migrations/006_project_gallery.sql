-- Flux Corp: Project Gallery Table
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
