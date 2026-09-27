# Database migrations

Migrations run in **filename order** (`001_…`, `002_…`, …).

## Apply all pending migrations

From the `server` folder (requires MySQL running and `server/.env`):

```bash
cd server
npm run migrate
```

This will:

1. Create the database (`DB_NAME`, default `flux_corp`) if it does not exist  
2. Create the `schema_migrations` table  
3. Run any `.sql` files in this folder that have not been applied yet  

## After first migrate

```bash
npm run seed:admin
```

Login: **admin** / **admin@Flux2026**

## Adding a new migration

Create the next numbered file, e.g. `021_add_feature.sql`:

- Use `CREATE TABLE IF NOT EXISTS` / safe `ALTER` where possible  
- Each file runs **once**; do not edit files that already ran in production (add a new migration instead)
