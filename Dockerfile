FROM ghcr.io/jobscale/php-fpm
COPY . .
RUN composer install || echo NG
RUN sed -i -e "s/APP_KEY=.*$/APP_KEY=$(php -r "require 'vendor/autoload.php'; echo str_random(32);")/" .env
RUN rm -fr html && ln -sfn public html
RUN chown -R nginx. .
