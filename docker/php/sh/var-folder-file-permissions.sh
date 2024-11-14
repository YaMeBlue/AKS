#!/bin/sh
set -e

mkdir -p /var/www/app/var/cache
mkdir -p /var/www/app/var/log
mkdir -p /var/www/app/vendor

if [ -d "/var/www/app/var" ]; then
  chown -R www-data:www-data "/var/www/app/var"
fi

if [ -d "/var/www/app/vendor" ]; then
  chown -R www-data:www-data "/var/www/app/vendor"
fi
