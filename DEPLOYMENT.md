# Flux Corp — Deployment Guide

## Production Architecture

```
[Client Browser] → [Nginx/CDN] → [React Static Build]
                                → [Nginx Reverse Proxy] → [Node.js API :5000]
                                                          → [MySQL Database]
```

## 1. Server Requirements

- Ubuntu 22.04 LTS (recommended)
- 2+ CPU cores, 4GB+ RAM
- Node.js 18 LTS
- MySQL 8.0
- Nginx

## 2. Database Setup (Production)

```bash
mysql -u root -p
CREATE DATABASE flux_corp CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'flux_user'@'localhost' IDENTIFIED BY 'STRONG_PASSWORD_HERE';
GRANT ALL PRIVILEGES ON flux_corp.* TO 'flux_user'@'localhost';
FLUSH PRIVILEGES;
EXIT;

mysql -u flux_user -p flux_corp < database/flux_corp.sql
```

## 3. Backend Deployment

```bash
cd server
cp .env.example .env
```

Production `.env`:

```env
PORT=5000
NODE_ENV=production
DB_HOST=localhost
DB_USER=flux_user
DB_PASSWORD=STRONG_PASSWORD_HERE
DB_NAME=flux_corp
JWT_SECRET=GENERATE_A_LONG_RANDOM_STRING
JWT_EXPIRES_IN=7d
CLIENT_URL=https://yourdomain.com
SMTP_HOST=smtp.yourprovider.com
SMTP_PORT=587
SMTP_USER=noreply@yourdomain.com
SMTP_PASS=SMTP_PASSWORD
SMTP_FROM=noreply@yourdomain.com
```

```bash
npm install --production
npm start
```

### PM2 Process Manager

```bash
npm install -g pm2
pm2 start index.js --name flux-corp-api
pm2 save
pm2 startup
```

## 4. Frontend Build

```bash
cd client
npm install
npm run build
```

Output in `client/dist/` — serve via Nginx.

## 5. Nginx Configuration

```nginx
server {
    listen 80;
    server_name yourdomain.com www.yourdomain.com;
    return 301 https://$server_name$request_uri;
}

server {
    listen 443 ssl http2;
    server_name yourdomain.com www.yourdomain.com;

    ssl_certificate /etc/letsencrypt/live/yourdomain.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/yourdomain.com/privkey.pem;

    root /var/www/flux-corp/client/dist;
    index index.html;

    # React SPA
    location / {
        try_files $uri $uri/ /index.html;
    }

    # API proxy
    location /api {
        proxy_pass http://127.0.0.1:5000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    # Uploads
    location /uploads {
        proxy_pass http://127.0.0.1:5000;
    }

    # Gzip
    gzip on;
    gzip_types text/plain text/css application/json application/javascript text/xml;
}
```

## 6. SSL with Let's Encrypt

```bash
sudo apt install certbot python3-certbot-nginx
sudo certbot --nginx -d yourdomain.com -d www.yourdomain.com
```

## 7. Security Checklist

- [ ] Change default admin password immediately
- [ ] Use strong JWT secret (64+ random characters)
- [ ] Enable MySQL SSL connections
- [ ] Configure firewall (allow 80, 443, 22 only)
- [ ] Set up automated MySQL backups
- [ ] Enable rate limiting on API (consider express-rate-limit)
- [ ] Configure CORS to production domain only
- [ ] Set secure HTTP headers via Nginx or helmet.js

## 8. Backup Strategy

```bash
# Daily MySQL backup cron
0 2 * * * mysqldump -u flux_user -p'PASSWORD' flux_corp | gzip > /backups/flux_corp_$(date +\%Y\%m\%d).sql.gz

# Uploads backup
0 3 * * * tar -czf /backups/uploads_$(date +\%Y\%m\%d).tar.gz /path/to/server/uploads
```

## 9. Monitoring

- Use PM2 monitoring: `pm2 monit`
- Set up uptime monitoring (UptimeRobot, Pingdom)
- Configure log rotation for PM2 and Nginx logs
- Monitor disk space for uploads directory

## 10. Environment-Specific Notes

### Docker (Optional)

Create `docker-compose.yml` with services: mysql, api, nginx for containerized deployment.

### CDN

Serve static assets from CloudFront/Cloudflare CDN for global performance.
Point CDN origin to Nginx static file root.

### Email

Configure Nodemailer SMTP for:
- Lead notification emails
- Job application confirmations
- Contact form auto-replies
