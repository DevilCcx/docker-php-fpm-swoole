FROM php:7.2-fpm

LABEL user = DevilCcx

RUN apt-get update && \
    apt-get install -y --allow-unauthenticated --no-install-recommends \
        libmemcached-dev \
        libz-dev \
        libpq-dev \
        libjpeg-dev \
        libpng-dev \
        libfreetype6-dev \
        libssl-dev \
        libmcrypt-dev \
        openssh-server \
        libmagickwand-dev \
        git \
        cron \
        nano \
        libxml2-dev


RUN apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
    && docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

# 安装一些拓展（soap、exif、mcrypt、pcntl、pdo_mysql、bcmath、imagick、gd ）
RUN docker-php-ext-install soap exif pcntl pdo_mysql bcmath \
    && pecl install mcrypt-1.0.2 imagick swoole \
    && docker-php-ext-enable mcrypt imagick swoole

#####################################
# Composer:
#####################################

# Install composer and add its bin to the PATH.
RUN curl -s http://getcomposer.org/installer | php && \
    echo "export PATH=${PATH}:/var/www/vendor/bin" >> ~/.bashrc && \
    mv composer.phar /usr/local/bin/composer && \
    composer config -g repo.packagist composer https://packagist.laravel-china.org

EXPOSE 9000

CMD ["php-fpm"]
