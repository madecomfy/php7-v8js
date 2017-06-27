FROM php:7.1-fpm

LABEL maintainer "tom@madecomfy.com.au"

RUN apt-get update && apt-get install -y --no-install-recommends \
    zlib1g-dev libicu-dev g++ apt-utils

COPY docker-php-pecl-install /usr/local/bin/

RUN docker-php-pecl-install xdebug-2.5.1 && \
    docker-php-ext-configure intl && \
    docker-php-ext-install intl && \
    docker-php-ext-configure opcache && \
    docker-php-ext-install opcache && \
    docker-php-ext-configure pdo_mysql && \
    docker-php-ext-install mysqli pdo_mysql && \
    apt-get update && apt-get upgrade -y
