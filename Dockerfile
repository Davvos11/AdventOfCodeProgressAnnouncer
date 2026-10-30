FROM php:8.2.35-cli@sha256:01176101b67743801164503341b6a70493814838185bc542b7272e718c5da7be

# Install system dependencies and SQLite PDO extension
RUN apt-get update && apt-get install -y \
    sqlite3 \
    libsqlite3-dev \
    unzip \
    && docker-php-ext-install pdo_sqlite

# Install Composer
COPY --from=composer:2.9@sha256:b09bccd91a78fe8a9ab4b33d707b862e8fe54fec17782e32683ad2a69c46867d /usr/bin/composer /usr/bin/composer

WORKDIR /app

COPY . .

RUN touch .env

RUN composer install

CMD ["php", "run.php"]