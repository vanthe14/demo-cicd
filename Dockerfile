FROM centos:7

RUN yum update -y
RUN yum install httpd -y
COPY ./docker/web/sample_app.conf /etc/httpd/conf.d

# Install PHP
RUN yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN yum -y install https://rpms.remirepo.net/enterprise/remi-release-7.rpm
RUN yum --enablerepo=remi-php73 -y \
        install php \
                php-bcmath \
                php-cli \
                php-common \
                php-gd \
                php-intl \
                php-ldap \
                php-mbstring \
                php-mysqlnd \
                php-pear \
                php-soap \
                php-xml \
                php-xmlrpc \
                php-zip \
                php-xdebug

COPY --chmod=777 . /var/www/hoclamweb
WORKDIR /var/www/hoclamweb
ENTRYPOINT ["/usr/sbin/httpd", "-D", "FOREGROUND"]

EXPOSE 80 443