ARG PHP_VERSION=8.0

FROM php:${PHP_VERSION}-apache

ARG GROUP_ID
ARG USER_ID

# init user
RUN groupadd -f -g $GROUP_ID user
RUN useradd -u $USER_ID -g $GROUP_ID user

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

RUN apt-get update \
    && apt-get install -y apt-utils zip unzip curl vim;

# install node
RUN apt-get install -y nodejs
RUN apt-get install -y npm
    
# Install composer
RUN curl -sSk https://getcomposer.org/installer | php -- --disable-tls && \
   mv composer.phar /usr/local/bin/composer

# extentions PHP
RUN docker-php-ext-install pdo pdo_mysql

# PHP memory
RUN echo 'memory_limit = 512M' >> /usr/local/etc/php/conf.d/docker-php-memlimit.ini;

USER user

WORKDIR /var/www/
