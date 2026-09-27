-- Flux Corp: Inquiries Table
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
