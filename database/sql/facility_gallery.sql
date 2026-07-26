-- Flux Corp: Facility Gallery Table
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
