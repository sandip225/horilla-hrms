FROM python:3.11-slim-bookworm AS builder

ENV PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y --no-install-recommends \
    libcairo2-dev \
    gcc \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app/

COPY requirements.txt .
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt
RUN pip install --no-cache-dir --prefix=/install gunicorn psycopg2-binary

FROM python:3.11-slim-bookworm AS runtime

ENV PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y --no-install-recommends \
    libcairo2 \
    libpq5 \
    curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app/

COPY --from=builder /install /usr/local

COPY . .

# Create necessary directories for media and static files
RUN mkdir -p /app/media /app/staticfiles /app/logs && \
    chmod -R 755 /app/media /app/staticfiles /app/logs

RUN chmod +x /app/entrypoint.sh

EXPOSE 8000

CMD ["sh", "./entrypoint.sh"]
