FROM php:7.4-fpm-alpine

WORKDIR /var/www/html

COPY src .

RUN docker-php-ext-install pdo pdo_mysql

RUN chown -R www-data:www-data /var/www/html

# www-data is the default user used by the pulled image

# if there's no an entrypoint or command explicitly defined the container will take the default one
# Which in this case is one used to sping up the php interpreter