FROM php:8.5.12-cli@sha256:50956f094e90a716d43bea28087d447555ad80510e386ab8c9c10d8c70d781a9

# Install system dependencies and SQLite PDO extension
RUN apt-get update && apt-get install -y \
    sqlite3 \
    libsqlite3-dev \
    unzip \
    && docker-php-ext-install pdo_sqlite

# Install Composer
COPY --from=composer:2.11@sha256:50ea4d33fdcde1adb0f045547295faa1548b33872e5f789dae5b02ce2fb5de93 /usr/bin/composer /usr/bin/composer

WORKDIR /app

COPY . .

RUN touch .env

RUN composer install

CMD ["php", "run.php"]