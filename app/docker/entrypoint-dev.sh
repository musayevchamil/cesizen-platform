#!/bin/sh
set -e

if [ ! -f .env ]; then
    cp .env.example .env
fi

if ! grep -q "APP_KEY=base64" .env 2>/dev/null; then
    php artisan key:generate --no-interaction
fi

chmod -R 777 storage bootstrap/cache

composer install
php artisan migrate

exec "$@"
