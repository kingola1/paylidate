FROM php:8.0-apache

RUN apt-get update && \
    apt-get install -y libicu-dev libonig-dev libzip-dev zip && \
    docker-php-ext-install intl pdo pdo_mysql && \
    docker-php-ext-configure zip && \
    docker-php-ext-install zip && \
    a2enmod rewrite

WORKDIR /var/www/html

COPY . .

# Laravel config
ENV APP_ENV production
ENV APP_DEBUG false
ENV LOG_CHANNEL stderr

RUN chown -R www-data:www-data /var/www/html/storage

RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

EXPOSE 80
