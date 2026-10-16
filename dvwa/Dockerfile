FROM php:7-apache

RUN echo "deb http://archive.debian.org/debian bullseye main" > /etc/apt/sources.list \
 && echo "deb http://archive.debian.org/debian-security bullseye-security main" >> /etc/apt/sources.list \
 && echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99no-check-valid

RUN apt-get update && apt-get install -y \
        libpng-dev \
        libjpeg-dev \
        libfreetype6-dev \
	unzip\
  	p7zip-full \	
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install mysqli gd pdo pdo_mysql \
    && rm -rf /var/lib/apt/lists/*

COPY ./php.ini /usr/local/etc/php/

WORKDIR /var/www/html/
COPY ./dvwa ./dvwa
COPY ./config.inc.php ./dvwa/config
RUN chmod o+w ./dvwa/config 
RUN chmod o+w ./dvwa/hackable/uploads

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('sha384', 'composer-setup.php') === 'c8b085408188070d5f52bcfe4ecfbee5f727afa458b2573b8eaaf77b3419b0bf2768dc67c86944da1544f06fa544fd47') { echo 'Installer verified'.PHP_EOL; } else { echo 'Installer corrupt'.PHP_EOL; unlink('composer-setup.php'); exit(1); }" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');"

RUN mv composer.phar /usr/bin/composer 
RUN cd dvwa/vulnerabilities/api && composer update && composer install

RUN a2enmod rewrite && service apache2 restart

#RUN chmod o+w ./dvwa/external/phpids/0.6/lib/IDS/tmp/phpids_log.txt

