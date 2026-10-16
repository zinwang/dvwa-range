FROM php:7-apache

RUN echo "deb http://archive.debian.org/debian bullseye main" > /etc/apt/sources.list \
 && echo "deb http://archive.debian.org/debian-security bullseye-security main" >> /etc/apt/sources.list \
 && echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99no-check-valid

RUN apt-get update && apt-get install -y \
        libpng-dev \
        libjpeg-dev \
        libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install mysqli gd pdo pdo_mysql \
    && rm -rf /var/lib/apt/lists/*
COPY ./php.ini /usr/local/etc/php/
WORKDIR /var/www/html/
COPY ./dvwa ./dvwa
RUN chmod o+w ./dvwa/config 
RUN chmod o+w ./dvwa/hackable/uploads 
RUN chmod o+w ./dvwa/external/phpids/0.6/lib/IDS/tmp/phpids_log.txt

