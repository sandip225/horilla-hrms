# Horilla HRMS Docker Quick Start Guide

## Prerequisites
- Docker installed (version 20.10+)
- Docker Compose installed (version 1.29+)
- At least 4GB RAM available
- 10GB disk space

## Quick Start (5 minutes)

### 1. Clone and Setup
```bash
cd horilla
cp .env.production.example .env
```

### 2. Update Configuration
Edit `.env` and set:
```bash
SECRET_KEY=your-random-secret-key-here
DB_PASSWORD=your-secure-password
ALLOWED_HOSTS=localhost,127.0.0.1,your-domain.com
```

### 3. Deploy
```bash
chmod +x deploy.sh
./deploy.sh
```

### 4. Access Application
- **URL**: http://localhost
- **Admin Panel**: http://localhost/admin
- **Default Credentials**: Check your setup

---

## Media Persistence (The Key!)

### How it works
The deployment script automatically creates Docker volumes:
- `horilla_media` - Stores uploaded files (logos, documents, etc.)
- `horilla_static` - Stores static files (CSS, JS, images)
- `postgres_data` - Stores database

### What this means
✅ Upload a company logo  
✅ Deploy a new version  
✅ Logo is still there!

### Verify volumes
```bash
docker volume ls | grep horilla
```

### Inspect volume contents
```bash
docker run --rm -v horilla_media:/media alpine ls -la /media
```

---

## Common Tasks

### View Logs
```bash
docker-compose -f docker-compose.production.yaml logs -f horilla
```

### Create Superuser
```bash
docker-compose -f docker-compose.production.yaml exec horilla python manage.py createsuperuser
```

### Access Shell
```bash
docker-compose -f docker-compose.production.yaml exec horilla bash
```

### Backup Media
```bash
docker run --rm -v horilla_media:/media -v $(pwd):/backup alpine tar czf /backup/media-backup.tar.gz -C /media .
```

### Restore Media
```bash
docker run --rm -v horilla_media:/media -v $(pwd):/backup alpine tar xzf /backup/media-backup.tar.gz -C /media
```

### Stop Services
```bash
docker-compose -f docker-compose.production.yaml down
```

### Restart Services
```bash
docker-compose -f docker-compose.production.yaml restart
```

### Update Application
```bash
# Pull latest code
git pull origin main

# Rebuild and restart
./deploy.sh
```

---

## Troubleshooting

### Logos not showing after deployment
1. Check volume exists: `docker volume ls | grep horilla_media`
2. Check volume contents: `docker run --rm -v horilla_media:/media alpine ls -la /media`
3. Clear browser cache (Ctrl+Shift+Delete)
4. Check database for correct paths: Admin → Companies → Check icon URL

### Port already in use
```bash
# Change port in docker-compose.production.yaml
# Change "80:80" to "8080:80" for example
docker-compose -f docker-compose.production.yaml up -d
```

### Database connection error
```bash
# Check database logs
docker-compose -f docker-compose.production.yaml logs db

# Restart database
docker-compose -f docker-compose.production.yaml restart db
```

### Out of disk space
```bash
# Clean up unused Docker resources
docker system prune -a

# Remove old volumes (WARNING: deletes data!)
docker volume prune
```

---

## Production Deployment

### For AWS/Azure/DigitalOcean

1. **Update .env for production**
```bash
DEBUG=False
ALLOWED_HOSTS=your-domain.com,www.your-domain.com
SECURE_SSL_REDIRECT=True
SESSION_COOKIE_SECURE=True
CSRF_COOKIE_SECURE=True
```

2. **Enable HTTPS in nginx.conf**
   - Uncomment HTTPS section
   - Add SSL certificates

3. **Use cloud storage (optional)**
```bash
USE_S3=True
AWS_STORAGE_BUCKET_NAME=your-bucket
AWS_ACCESS_KEY_ID=your-key
AWS_SECRET_ACCESS_KEY=your-secret
```

4. **Deploy**
```bash
./deploy.sh
```

---

## Architecture

```
┌─────────────────────────────────────────┐
│         Your Domain (nginx)             │
│         Port 80/443                     │
└────────────────┬────────────────────────┘
                 │
        ┌────────▼────────┐
        │  Nginx Reverse  │
        │     Proxy       │
        └────────┬────────┘
                 │
    ┌────────────┼────────────┐
    │            │            │
┌───▼──┐  ┌─────▼────┐  ┌────▼────┐
│Static│  │ Horilla  │  │ Database │
│Files │  │   App    │  │(Postgres)│
└──────┘  └──────────┘  └──────────┘
    │            │            │
    └────────────┼────────────┘
                 │
    ┌────────────▼────────────┐
    │   Docker Volumes        │
    │ ┌──────────────────────┐│
    │ │ horilla_media        ││ ← Logos, uploads
    │ │ horilla_static       ││ ← CSS, JS
    │ │ postgres_data        ││ ← Database
    │ └──────────────────────┘│
    └─────────────────────────┘
```

---

## Performance Tips

1. **Enable Gzip compression** (already in nginx.conf)
2. **Use CDN for static files** (configure in settings.py)
3. **Enable database connection pooling** (pgBouncer)
4. **Set up monitoring** (Prometheus, Grafana)
5. **Regular backups** (automated daily)

---

## Support

For issues or questions:
1. Check logs: `docker-compose logs -f`
2. Read DOCKER_MEDIA_PERSISTENCE.md for detailed info
3. Check Docker documentation: https://docs.docker.com
4. Check Horilla documentation: https://horilla.readthedocs.io

---

## Next Steps

- [ ] Deploy application
- [ ] Create superuser account
- [ ] Upload company logo
- [ ] Test media persistence
- [ ] Set up SSL/HTTPS
- [ ] Configure email
- [ ] Set up backups
- [ ] Monitor application
