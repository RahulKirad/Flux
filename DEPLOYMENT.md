# Flux Corp — Production deployment

## Architecture

| Layer | Host | Notes |
|--------|------|--------|
| **Public website** | Vercel (`vercel.json` builds `client/`) | Static React app |
| **API + uploads + admin data** | Node server (`server/`) | MySQL required; serves `/api` and `/uploads` |

Consultation forms and `/admin` **must** talk to the live API. Set the frontend API URL in Vercel.

## 1. Database (MySQL)

1. Set `DB_*` in the API environment (`server/.env`).
2. Run migrations:

   ```bash
   cd server && npm run migrate
   ```

   (Creates `flux_corp` if needed and applies `database/migrations/*.sql`.)

## 2. API server

1. Deploy `server/` (Railway, Render, VPS, etc.).
2. Environment variables (see `server/.env.example`):

   - `PORT`, `NODE_ENV=production`
   - `DB_HOST`, `DB_USER`, `DB_PASSWORD`, `DB_NAME`
   - `JWT_SECRET` (long random string)
   - `CLIENT_URL=https://your-vercel-domain.vercel.app`
   - `SMTP_*` and `LEAD_NOTIFICATION_EMAIL` for consultation emails

3. Create admin user:

   ```bash
   cd server && npm run seed:admin
   ```

   **Login:** username `admin` — password `admin@Flux2026`  
   (Account email in DB: `admin@fluxcorp.com`)

4. Ensure `uploads/` is on persistent disk (not ephemeral) so media and hero videos survive redeploys.

## 3. Vercel (frontend)

Project settings → Environment variables:

| Variable | Example |
|----------|---------|
| `VITE_API_URL` | `https://api.yourdomain.com` |

Redeploy after setting. Without this, forms and admin only work on localhost (Vite proxy).

## 4. CORS

The API allows `CLIENT_URL` and any `*.vercel.app` origin. Add your custom domain to `CLIENT_URL` if needed.

## 5. Admin usage

- URL: `https://your-site.com/admin`
- **Leads** — engineering consultation requests (service name stored in message + `service_id` when DB has services).
- **Site Content** — hero video, headlines, homepage copy, image URL overrides.
- **Media** — upload images/videos; paste `/uploads/...` paths into Site Content.
- **Services / Projects / Blogs / …** — CMS records served by API when present (static fallbacks remain if API is empty).

## 6. Health check

`GET https://your-api/api/health` should return `{ "success": true }`.
