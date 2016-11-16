# start from base
FROM ubuntu:16.04
MAINTAINER Vishal Mene <vishal.mene@gmail.com>

#ADD Document root
#RUN mkdir /var/www/html

# install system-wide 

RUN apt-get -yqq update
RUN apt-get -yqq install apache2
RUN chown www-data:www-data /var/www/html -Rf
RUN apt-get -yqq install php7.0 libapache2-mod-php7.0 php7.0-mysql
RUN /usr/sbin/apache2ctl restart 

COPY . /var/www/html

RUN chown www-data:www-data /var/www/html/info.php
RUN chown www-data:www-data /var/www/html/connect.php

RUN /usr/sbin/a2dismod 'mpm_*' && /usr/sbin/a2enmod mpm_prefork
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 80
EXPOSE 443

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
