# Flux Corp — Corporate Website & Admin CMS

Enterprise-grade engineering company website and content management platform for Flux Corp.

## Tech Stack

| Layer | Technologies |
|-------|-------------|
| Frontend | React 19, Vite, TypeScript, Tailwind CSS, Framer Motion, React Router, React Query, React Hook Form |
| Backend | Node.js, Express.js, JWT, Multer, Nodemailer |
| Database | MySQL |

## Project Structure

```
/client          → React frontend (public website + admin CMS)
/server          → Express API (MVC + Service + Repository layers)
/database/sql    → 20 MySQL schema files with seed data
```

## Quick Start

### Prerequisites

- Node.js 18+
- MySQL 8.0+

### 1. Install Dependencies

```bash
npm run install:all
```

### 2. Database Setup

```bash
mysql -u root -p < database/flux_corp.sql
```

This single file creates the database, all 20 tables, foreign keys, indexes, and seed data.

Individual table files are also available in `database/sql/` if you prefer modular imports.

### 3. Configure Environment

```bash
cp server/.env.example server/.env
```

Edit `server/.env` with your MySQL credentials and JWT secret.

Default admin credentials (included in seed data):
- **Email:** admin@fluxcorp.com
- **Password:** Admin@123

### 4. Run Development

```bash
npm run dev
```

- Website: http://localhost:5173
- API: http://localhost:5000
- Admin CMS: http://localhost:5173/admin/login

## API Endpoints

| Route | Description |
|-------|-------------|
| `/api/auth` | Authentication (login, profile) |
| `/api/services` | Services CRUD |
| `/api/projects` | Projects & gallery |
| `/api/industries` | Industries |
| `/api/case-studies` | Case studies |
| `/api/blogs` | Blog posts & categories |
| `/api/certifications` | Certifications |
| `/api/facilities` | Manufacturing facilities |
| `/api/careers` | Job openings & applications |
| `/api/leads` | Lead capture & management |
| `/api/media` | Media library uploads |
| `/api/settings` | Company settings, SEO, dashboard |

## Admin Roles

1. **Super Admin** — Full access
2. **Admin** — Users, content, leads, settings
3. **Content Manager** — Website content modules
4. **Sales Team** — Leads, inquiries, careers

## Deployment

See [DEPLOYMENT.md](./DEPLOYMENT.md) for production deployment guide.

## License

Proprietary — Flux Corp
