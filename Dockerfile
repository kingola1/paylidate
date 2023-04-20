FROM php:7.4-apache

WORKDIR /var/www/html

RUN apt-get update && \
    apt-get install -y \
        libzip-dev \
        unzip \
        git \
        libonig-dev \
        libxml2-dev \
        libpng-dev \
        libjpeg-dev \
        libfreetype6-dev \
        && docker-php-ext-install \
            pdo_mysql \
            mysqli \
            mbstring \
            zip \
            exif \
            pcntl \
            bcmath \
            opcache \
            && docker-php-ext-configure gd \
            --with-freetype=/usr/include/ \
            --with-jpeg=/usr/include/ \
            && docker-php-ext-install gd

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY . /var/www/html

RUN composer install --no-dev --optimize-autoloader

RUN chown -R www-data:www-data /var/www/html
