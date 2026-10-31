FROM php:8.2.35-cli@sha256:a76ea7d3dd8f65eefff85e9c883f4d146808e0075c30ae6bccbb2a3753d373b8

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