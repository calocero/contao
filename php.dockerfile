FROM php:7.4-apache

ENV APACHE_DOCUMENT_ROOT /var/www/html/contao/public
WORKDIR /var/www/html

RUN apt update && apt install -y \
		libfreetype6-dev \
		libjpeg62-turbo-dev \
		libpng-dev \
        libicu-dev \
        git zip

RUN	docker-php-ext-install -j$(nproc) iconv && \
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
	docker-php-ext-install -j$(nproc) gd && \
    docker-php-ext-install -j$(nproc) intl && \
    docker-php-ext-install -j$(nproc) pdo_mysql

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf
RUN a2enmod rewrite && a2enmod ssl

COPY ./ssl-certs /etc/apache2/ssl-certs
COPY ./apache2/default-ssl.conf /etc/apache2/sites-available/default-ssl.conf
COPY ./contao ./contao
RUN a2ensite default-ssl && service apache2 restart
RUN chown -R www-data:www-data ./contao
