#!/bin/sh
set -e

eval $(printenv | sed -n "s/^\([^=]\+\)=\(.*\)$/export \1=\2/p" | sed 's/"/\\\"/g' | sed '/=/s//="/' | sed 's/$/"/' >> /etc/profile)
env > /etc/environment

su www-data -s /usr/local/bin/composer-scripts.sh

# Database creation and migration
# php bin/console doctrine:database:create --if-not-exists
# php bin/console doctrine:migrations:migrate -n --allow-no-migration

cp /setup/supervisor/configs/main.conf /etc/supervisor/conf.d/confs/

/usr/bin/supervisord -c /etc/supervisor/conf.d/supervisor.conf

exec docker-php-entrypoint "$@"
