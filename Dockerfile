FROM centos

MAINTAINER Mikk3lRo <mikk3lro@gmail.com>

VOLUME /sys/fs/cgroup /run /tmp
ENV container=docker

RUN echo "# MariaDB 10.3 CentOS repository list - created 2018-06-17 06:36 UTC" > /etc/yum.repos.d/mariadb.repo
RUN echo "# http://downloads.mariadb.org/mariadb/repositories/" >> /etc/yum.repos.d/mariadb.repo
RUN echo "[mariadb]" >> /etc/yum.repos.d/mariadb.repo
RUN echo "name=MariaDB" >> /etc/yum.repos.d/mariadb.repo
RUN echo "baseurl=http://yum.mariadb.org/10.3/centos7-amd64/" >> /etc/yum.repos.d/mariadb.repo
RUN echo "gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB" >> /etc/yum.repos.d/mariadb.repo
RUN echo "gpgcheck=0" >>  /etc/yum.repos.d/mariadb.repo

RUN yum -y install epel-release
RUN rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
RUN yum -y update
RUN yum -y install \
                   MariaDB-server MariaDB-client \
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
                   git \
                   sudo

RUN curl -fsSL https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && composer global require phpunit/phpunit ^6 --no-progress --no-scripts --no-interaction \
    && composer global require squizlabs/php_codesniffer ~3.3 --no-progress --no-scripts --no-interaction \
    && composer global require composer/satis --no-progress --no-scripts --no-interaction

RUN php -m | grep xdebug

ENV PATH /root/.composer/vendor/bin:$PATH

RUN git config --global push.default simple