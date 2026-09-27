-- Flux Corp: Master Database Setup
-- Preferred:  cd server && npm run migrate
-- Alternative single-file import:  mysql -u root -p < database/flux_corp.sql
--
-- This file is kept for modular imports from the sql/ folder.

CREATE DATABASE IF NOT EXISTS flux_corp CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE flux_corp;

SOURCE roles.sql;
SOURCE users.sql;
SOURCE services.sql;
SOURCE industries.sql;
SOURCE projects.sql;
SOURCE project_gallery.sql;
SOURCE case_studies.sql;
SOURCE blog_categories.sql;
SOURCE blog_tags.sql;
SOURCE blogs.sql;
SOURCE certifications.sql;
SOURCE facilities.sql;
SOURCE facility_gallery.sql;
SOURCE careers.sql;
SOURCE applications.sql;
SOURCE leads.sql;
SOURCE inquiries.sql;
SOURCE seo.sql;
SOURCE media_library.sql;
SOURCE settings.sql;
