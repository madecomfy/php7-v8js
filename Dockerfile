FROM ubuntu:trusty

LABEL maintainer "tom@madecomfy.com.au"

RUN apt-get update && apt install -y --no-install-recommends \
    software-properties-common build-essential \
    git python libglib2.0-dev \
    curl wget libcurl3-openssl-dev

RUN add-apt-repository ppa:pinepain/libv8-5.2 -y && \
    add-apt-repository ppa:ondrej/php -y && \
    apt-get update

RUN apt-get install -y --force-yes \
    php7.1-fpm php7.1-dev \
    php7.1-mysql php7.1-xml php-curl php-intl php-pear

RUN pecl install xdebug

RUN apt-get install libv8-5.2

RUN cd /tmp && \
    git clone https://github.com/phpv8/v8js.git && \
    cd v8js && \
    phpize && \
    ./configure --with-v8js=/opt/v8 && \
    make && \
    make test && \
    make install

RUN apt-get update && apt-get upgrade --force-yes -y
