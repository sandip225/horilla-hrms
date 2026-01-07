#!/bin/bash

# Horilla HRMS Docker Deployment Script
# This script handles deployment with media persistence

set -e

echo "=========================================="
echo "Horilla HRMS Docker Deployment"
echo "=========================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if .env file exists
if [ ! -f .env ]; then
    echo -e "${YELLOW}Warning: .env file not found${NC}"
    echo "Creating .env from .env.production.example..."
    cp .env.production.example .env
    echo -e "${RED}Please update .env with your configuration${NC}"
    exit 1
fi

# Load environment variables
export $(cat .env | grep -v '#' | xargs)

echo -e "${GREEN}Step 1: Checking Docker and Docker Compose${NC}"
docker --version
docker-compose --version

echo -e "${GREEN}Step 2: Creating volumes if they don't exist${NC}"
docker volume create horilla_media 2>/dev/null || echo "Volume horilla_media already exists"
docker volume create horilla_static 2>/dev/null || echo "Volume horilla_static already exists"
docker volume create postgres_data 2>/dev/null || echo "Volume postgres_data already exists"

echo -e "${GREEN}Step 3: Building Docker images${NC}"
docker-compose -f docker-compose.production.yaml build

echo -e "${GREEN}Step 4: Starting services${NC}"
docker-compose -f docker-compose.production.yaml up -d

echo -e "${GREEN}Step 5: Waiting for services to be ready${NC}"
sleep 10

echo -e "${GREEN}Step 6: Running database migrations${NC}"
docker-compose -f docker-compose.production.yaml exec -T horilla python manage.py migrate

echo -e "${GREEN}Step 7: Collecting static files${NC}"
docker-compose -f docker-compose.production.yaml exec -T horilla python manage.py collectstatic --noinput

echo -e "${GREEN}Step 8: Verifying deployment${NC}"
echo "Checking Horilla service..."
docker-compose -f docker-compose.production.yaml exec -T horilla curl -f http://localhost:8000/ > /dev/null && echo -e "${GREEN}✓ Horilla is running${NC}" || echo -e "${RED}✗ Horilla is not responding${NC}"

echo "Checking Nginx service..."
docker-compose -f docker-compose.production.yaml exec -T nginx curl -f http://localhost/ > /dev/null && echo -e "${GREEN}✓ Nginx is running${NC}" || echo -e "${RED}✗ Nginx is not responding${NC}"

echo "Checking Database service..."
docker-compose -f docker-compose.production.yaml exec -T db pg_isready -U $DB_USER > /dev/null && echo -e "${GREEN}✓ Database is running${NC}" || echo -e "${RED}✗ Database is not responding${NC}"

echo -e "${GREEN}Step 9: Checking media volume${NC}"
MEDIA_COUNT=$(docker run --rm -v horilla_media:/media alpine ls -la /media | wc -l)
echo "Media volume contains $MEDIA_COUNT items"

echo ""
echo "=========================================="
echo -e "${GREEN}Deployment completed successfully!${NC}"
echo "=========================================="
echo ""
echo "Services running:"
docker-compose -f docker-compose.production.yaml ps
echo ""
echo "Useful commands:"
echo "  View logs:           docker-compose -f docker-compose.production.yaml logs -f horilla"
echo "  Stop services:       docker-compose -f docker-compose.production.yaml down"
echo "  Restart services:    docker-compose -f docker-compose.production.yaml restart"
echo "  Access shell:        docker-compose -f docker-compose.production.yaml exec horilla bash"
echo "  Create superuser:    docker-compose -f docker-compose.production.yaml exec horilla python manage.py createsuperuser"
echo ""
echo "Media persistence:"
echo "  Media volume:        horilla_media"
echo "  Static volume:       horilla_static"
echo "  Database volume:     postgres_data"
echo ""
echo "Access your application at: http://localhost"
echo ""
