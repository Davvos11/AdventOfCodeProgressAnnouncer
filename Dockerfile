FROM php:8.5.12-cli@sha256:50956f094e90a716d43bea28087d447555ad80510e386ab8c9c10d8c70d781a9

# Install system dependencies and SQLite PDO extension
RUN apt-get update && apt-get install -y \
    sqlite3 \
    libsqlite3-dev \
    unzip \
    && docker-php-ext-install pdo_sqlite

# Install Composer
COPY --from=composer:2.10@sha256:2cf275428757e5435a667bfc0d038b14520ca02be2b1b70d44a05c8c19e2de48 /usr/bin/composer /usr/bin/composer

WORKDIR /app

COPY . .

RUN touch .env

RUN composer install

CMD ["php", "run.php"]