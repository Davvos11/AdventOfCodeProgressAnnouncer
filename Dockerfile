FROM php:8.5.11-cli@sha256:8e5d746f87655d89573e76d2b9125ed1b1578e47d3c466a2b2fdfc35593d9b41

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