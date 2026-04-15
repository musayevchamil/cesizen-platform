# Stage 1: Svelte assets
FROM node:20-alpine AS assets
WORKDIR /app
COPY app/package*.json ./
RUN npm ci
COPY app/ .
RUN npm run build

# Stage 2: base PHP
FROM php:8.4-fpm-alpine AS base

RUN apk add --no-cache \
    nginx \
    supervisor \
    curl \
    libpq-dev \
    libpng-dev \
    libxml2-dev \
    oniguruma-dev \
    zip \
    unzip

RUN docker-php-ext-install \
    pdo \
    pdo_pgsql \
    mbstring \
    xml \
    ctype \
    fileinfo \
    bcmath \
    opcache

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

RUN mkdir -p /var/log/supervisor

COPY app/docker/nginx.conf /etc/nginx/nginx.conf
COPY app/docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

WORKDIR /var/www/html

# Stage 3: dev
FROM base AS dev

COPY app/docker/opcache-dev.ini /usr/local/etc/php/conf.d/opcache.ini
COPY app/docker/entrypoint-dev.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

# Stage 4: production
FROM base AS production

COPY app/docker/opcache.ini /usr/local/etc/php/conf.d/opcache.ini

COPY app/ .
COPY --from=assets /app/public/build ./public/build

RUN composer install --no-dev --optimize-autoloader --no-interaction

RUN rm -rf docker \
    && chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html/storage \
    && chmod -R 755 /var/www/html/bootstrap/cache

COPY app/docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
