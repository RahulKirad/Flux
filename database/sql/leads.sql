-- Flux Corp: Leads Table
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
