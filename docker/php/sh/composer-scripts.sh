#!/bin/sh
set -e

if [ -f "/var/www/app/vendor/autoload.php" ]; then
  composer run-script post-install-cmd
fi
