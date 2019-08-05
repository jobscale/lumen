FROM php:7.3-fpm-buster

WORKDIR /var/www

RUN apt update && apt install -y nginx nginx-extras unzip git

COPY . .
RUN ./composer.phar install && sed -i -e "s/APP_KEY=.*$/APP_KEY=$(php -r "require 'vendor/autoload.php'; echo str_random(32);")/" .env

COPY default /etc/nginx/sites-enabled/default
RUN rm -fr html && ln -s public html && chown -R www-data. storage resources bootstrap

EXPOSE 80
CMD ["bash", "-c", "nginx && php-fpm"]
