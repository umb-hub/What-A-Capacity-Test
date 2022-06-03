FROM php:7.1-apache

RUN docker-php-ext-install pdo_mysql mysqli opcache

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

RUN service apache2 restart