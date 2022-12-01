FROM php:7.3-apache

ARG IS_READY

RUN apt-get update
RUN apt-get install nginx -y
RUN apt-get install vim -y
RUN apt-get update && apt-get install -y git
RUN docker-php-ext-install pdo pdo_mysql mysqli
RUN apt-get install -y python3 python3-pip
RUN a2enmod rewrite
RUN pip install requests

RUN mkdir /content
COPY ./default.conf /etc/nginx/sites-enabled/default
COPY ./src /content
VOLUME [ "/content" ]

RUN if [ "$IS_READY" = "true" ] ; then echo "We are ready" > /content/index.html ; else echo "We are not ready" > /content/index.html ; fi

COPY src /var/www/html/
EXPOSE 80/tcp
EXPOSE 443/tcp
