FROM nginx:stable-alpine AS nginx

ENV ROOT_DIR=/var/www/app

RUN apk update && apk add --no-cache \
    bash

COPY ./docker/nginx/nginx.conf /etc/nginx/nginx.conf

COPY ./docker/nginx/docker-healthcheck.sh /usr/local/bin/docker-healthcheck.sh
RUN chmod -R a+x /usr/local/bin/docker-healthcheck.sh

HEALTHCHECK --interval=1m --timeout=3s --retries=3 --start-period=30s CMD ["docker-healthcheck.sh"]

EXPOSE 80

RUN mkdir -p /var/log/nginx
COPY --chown=nginx ./public "${ROOT_DIR}/public/"
WORKDIR "${ROOT_DIR}/public/"

CMD ["nginx", "-g", "daemon off;"]