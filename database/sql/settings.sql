-- Flux Corp: Settings Table
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
