#!/bin/sh
set -e

if [[ -f "/var/www/app/composer.json" ]]; then
  composer install --no-dev --classmap-authoritative --no-scripts
  php bin/console cache:clear --env=prod --no-debug
fi
