FROM centos

MAINTAINER Mikk3lRo <mikk3lro@gmail.com>

VOLUME /sys/fs/cgroup /run /tmp
ENV container=docker

RUN yum -y install epel-release
RUN rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
RUN yum -y update
RUN yum -y install \
                   php72w-cli \
                   php72w-common \
                   php72w-devel \
                   php72w-mbstring \
                   php72w-mysql \
                   php72w-pdo \
                   php72w-pear \
                   php72w-pecl-xdebug \
                   php72w-process \
                   php72w-xml \
                   git

RUN curl -fsSL https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && composer global require phpunit/phpunit ^6 --no-progress --no-scripts --no-interaction \
    && composer global require squizlabs/php_codesniffer ~3.3 --no-progress --no-scripts --no-interaction \
    && composer global require composer/satis --no-progress --no-scripts --no-interaction

RUN php -m | grep xdebug

ENV PATH /root/.composer/vendor/bin:$PATH