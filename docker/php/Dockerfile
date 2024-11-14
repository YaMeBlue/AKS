FROM php:8.2-fpm-alpine AS app

ENV COMPOSER_PATH=/.composer/

RUN apk update && apk add --no-cache \
    bash \
    supervisor

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/bin/
RUN install-php-extensions

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
COPY ./docker/php/zz-docker.conf /usr/local/etc/php-fpm.d/

RUN mkdir ${COMPOSER_PATH}
RUN chown -R www-data:www-data ${COMPOSER_PATH}

COPY --chown=www-data . /var/www/app
WORKDIR /var/www/app

# Copy entrypoint & scripts -------------------
COPY ./docker/php/sh/var-folder-file-permissions.sh /usr/local/bin/var-folder-file-permissions.sh
COPY ./docker/php/sh/composer-install.sh /usr/local/bin/composer-install.sh
COPY ./docker/php/sh/composer-scripts.sh /usr/local/bin/composer-scripts.sh
COPY ./docker/php/sh/docker-healthcheck.sh /usr/local/bin/docker-healthcheck.sh
COPY ./docker/php/sh/zz-fpm-entrypoint.sh /zz-fpm-entrypoint.sh
RUN chmod -R a+x /usr/local/bin/var-folder-file-permissions.sh
RUN chmod -R a+x /usr/local/bin/composer-install.sh
RUN chmod -R a+x /usr/local/bin/composer-scripts.sh
RUN chmod -R a+x /usr/local/bin/docker-healthcheck.sh
RUN chmod -R a+x /zz-fpm-entrypoint.sh

# Supervisor
RUN mkdir -p /setup/supervisor/configs
RUN mkdir -p /etc/supervisor/conf.d/confs
COPY ./docker/php/supervisor/conf.d/ /setup/supervisor/configs/
COPY ./docker/php/supervisor/supervisor.conf /etc/supervisor/conf.d/supervisor.conf

# Configurations
RUN mkdir -p /config
COPY ./config/ /config/

HEALTHCHECK --interval=1m --timeout=3s --retries=3 --start-period=30s CMD ["docker-healthcheck.sh"]

EXPOSE 9000

ENTRYPOINT ["/zz-fpm-entrypoint.sh"]

# Setup project files and install vendor files
RUN sh /usr/local/bin/var-folder-file-permissions.sh
RUN /usr/local/bin/composer-install.sh && chown -R www-data:www-data ./vendor

RUN chown -R www-data:www-data /var/www/app