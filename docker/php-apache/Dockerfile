FROM php:7.1-apache

RUN docker-php-ext-install pdo_mysql mysqli opcache

RUN service apache2 restart
