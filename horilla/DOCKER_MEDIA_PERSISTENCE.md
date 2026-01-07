# Docker Media Persistence Guide for Horilla HRMS

## Problem
When deploying new versions of Horilla in Docker containers, uploaded media files (like company logos) are lost because Docker containers are ephemeral. The database still references the old paths, but the files don't exist.

## Solution Overview
This guide provides multiple solutions to ensure media files persist across Docker deployments.

---

## Solution 1: Docker Volumes (Recommended)

### Setup
Update your `docker-compose.yaml`:

```yaml
version: '3.8'

services:
  horilla:
    image: horilla:latest
    volumes:
      - horilla_media:/app/media
      - horilla_static:/app/staticfiles
    environment:
      - MEDIA_ROOT=/app/media
      - STATIC_ROOT=/app/staticfiles

volumes:
  horilla_media:
    driver: local
  horilla_static:
    driver: local
```

### How it works
- Docker volumes persist data outside the container filesystem
- Media files uploaded to `/app/media` are stored in the `horilla_media` volume
- Even when you redeploy with a new container, the volume persists
- The database references remain valid

### Deploy with volumes
```bash
docker-compose up -d
```

---

## Solution 2: Bind Mounts (For Development/Testing)

### Setup
```yaml
services:
  horilla:
    image: horilla:latest
    volumes:
      - ./media:/app/media
      - ./staticfiles:/app/staticfiles
```

### How it works
- Maps host machine directories to container directories
- Media files are stored on your host machine
- Useful for development and testing

---

## Solution 3: Cloud Storage (AWS S3, Azure Blob, etc.)

### Setup with AWS S3

1. Install django-storages:
```bash
pip install django-storages boto3
```

2. Update `settings.py`:
```python
if os.getenv('USE_S3', False):
    # AWS S3 Configuration
    AWS_STORAGE_BUCKET_NAME = os.getenv('AWS_STORAGE_BUCKET_NAME')
    AWS_S3_REGION_NAME = os.getenv('AWS_S3_REGION_NAME', 'us-east-1')
    AWS_S3_CUSTOM_DOMAIN = f'{AWS_STORAGE_BUCKET_NAME}.s3.amazonaws.com'
    AWS_S3_OBJECT_PARAMETERS = {'CacheControl': 'max-age=86400'}
    
    # S3 static settings
    STATIC_URL = f'https://{AWS_S3_CUSTOM_DOMAIN}/static/'
    STATIC_ROOT = 'static/'
    STATICFILES_STORAGE = 'storages.backends.s3boto3.S3Boto3Storage'
    
    # S3 public media settings
    PUBLIC_MEDIA_LOCATION = 'media'
    MEDIA_URL = f'https://{AWS_S3_CUSTOM_DOMAIN}/{PUBLIC_MEDIA_LOCATION}/'
    DEFAULT_FILE_STORAGE = 'storages.backends.s3boto3.S3Boto3Storage'
else:
    MEDIA_URL = '/media/'
    MEDIA_ROOT = os.path.join(BASE_DIR, 'media')
```

3. Docker environment variables:
```yaml
services:
  horilla:
    environment:
      - USE_S3=True
      - AWS_STORAGE_BUCKET_NAME=my-horilla-bucket
      - AWS_S3_REGION_NAME=us-east-1
      - AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
      - AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
```

### How it works
- Media files are uploaded to cloud storage (S3, Azure, etc.)
- Database stores cloud URLs instead of local paths
- Files persist across all deployments
- Scalable and reliable

---

## Solution 4: Dynamic Fallback (Already Implemented)

The application now includes dynamic fallback filters that handle missing logos gracefully.

### How it works
1. When a logo URL is requested, the system checks if the file exists
2. If the file exists, it returns the file URL
3. If the file doesn't exist, it returns a fallback avatar from `ui-avatars.com`
4. The fallback avatar is generated dynamically with the company name

### Template Usage
```django
{% load basefilters %}

<!-- Using the filter -->
<img src="{{ company|get_company_logo }}" alt="Company Logo" />

<!-- Or with icon field -->
<img src="{{ company.icon|get_company_logo_url }}" alt="Company Logo" />
```

---

## Best Practice: Hybrid Approach

Combine multiple solutions for maximum reliability:

```yaml
version: '3.8'

services:
  horilla:
    image: horilla:latest
    volumes:
      - horilla_media:/app/media
      - horilla_static:/app/staticfiles
    environment:
      - MEDIA_ROOT=/app/media
      - STATIC_ROOT=/app/staticfiles
      - USE_S3=True  # Optional: for backup
      - AWS_STORAGE_BUCKET_NAME=${AWS_STORAGE_BUCKET_NAME}

volumes:
  horilla_media:
    driver: local
  horilla_static:
    driver: local
```

---

## Dockerfile Best Practices

### Ensure media directory exists
```dockerfile
FROM python:3.11

WORKDIR /app

# Create media and static directories
RUN mkdir -p /app/media /app/staticfiles

# Copy application
COPY . .

# Install dependencies
RUN pip install -r requirements.txt

# Collect static files
RUN python manage.py collectstatic --noinput

# Set permissions
RUN chmod -R 755 /app/media /app/staticfiles

EXPOSE 8000
CMD ["gunicorn", "horilla.wsgi:application", "--bind", "0.0.0.0:8000"]
```

---

## Nginx Configuration (For Production)

```nginx
server {
    listen 80;
    server_name your-domain.com;

    # Media files
    location /media/ {
        alias /app/media/;
        expires 30d;
        add_header Cache-Control "public, immutable";
    }

    # Static files
    location /static/ {
        alias /app/staticfiles/;
        expires 30d;
        add_header Cache-Control "public, immutable";
    }

    # Application
    location / {
        proxy_pass http://horilla:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

---

## Deployment Checklist

- [ ] Choose a media persistence solution (volumes, cloud storage, or hybrid)
- [ ] Update `docker-compose.yaml` with volumes or environment variables
- [ ] Update `settings.py` if using cloud storage
- [ ] Test logo upload and persistence
- [ ] Verify fallback avatars work if files are missing
- [ ] Set up backup strategy for media files
- [ ] Configure Nginx/reverse proxy for media serving
- [ ] Document your media persistence strategy

---

## Troubleshooting

### Logos not showing after deployment
1. Check if volume is mounted: `docker volume ls`
2. Verify media directory permissions: `docker exec horilla ls -la /app/media`
3. Check browser cache: Clear cache or use incognito mode
4. Verify database paths are correct: Check admin panel for company icon URLs

### Volume not persisting
1. Ensure volume is defined in docker-compose.yaml
2. Check volume exists: `docker volume inspect horilla_media`
3. Verify container is using the volume: `docker inspect horilla | grep -A 10 Mounts`

### S3 upload issues
1. Verify AWS credentials are correct
2. Check S3 bucket permissions
3. Verify bucket name and region in settings
4. Check CloudFront distribution if using CDN

---

## References
- [Docker Volumes Documentation](https://docs.docker.com/storage/volumes/)
- [Django Storages Documentation](https://django-storages.readthedocs.io/)
- [AWS S3 Configuration](https://docs.aws.amazon.com/s3/)
