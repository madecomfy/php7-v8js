FROM ubuntu:trusty

LABEL maintainer "tom@madecomfy.com.au"

RUN apt-get update && apt-get install -y --no-install-recommends \
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

RUN mkdir -p /var/www/html

RUN rm -f /etc/php/7.1/fpm/pool.d/*
COPY conf/pool.d/www.conf /etc/php/7.1/fpm/pool.d/www.conf
COPY conf/pool.d/zz-docker.conf /etc/php/7.1/fpm/pool.d/zz-docker.conf
COPY conf/php-fpm.conf /etc/php/7.1/fpm/php-fpm.conf

RUN service php7.1-fpm start

EXPOSE 9000
CMD ["php-fpm7.1", "--nodaemonize", "--force-stderr"]
