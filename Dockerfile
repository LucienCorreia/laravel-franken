FROM --platform=$BUILDPLATFORM dunglas/frankenphp:php8.4-alpine

RUN apk add --no-cache composer \
    ${PHPIZE_DEPS} \
    php-fileinfo \
    php-tokenizer \
    php-session \
    php-dom \
    php-xmlwriter \
    php-xml \
    php-simplexml

WORKDIR /app

COPY ./laravel /app

RUN composer install

RUN cp .env.example .env

RUN php artisan key:generate

RUN chown -R www-data:www-data /app

EXPOSE 80

CMD ["frankenphp", "php-server", "-r", "public/"]