FROM jobscale/php-fpm

WORKDIR /var/www

COPY . .

RUN ./composer.phar install \
&& sed -i -e "s/APP_KEY=.*$/APP_KEY=$(php -r "require 'vendor/autoload.php'; echo str_random(32);")/" .env \
&& rm -fr html && ln -s public html \
&& chown -R www-data. storage resources bootstrap
