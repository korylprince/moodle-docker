#!/bin/sh

/run-every "$CRON_INTERVAL" php7 /moodle/admin/cli/cron.php &

exec php-fpm7 -F
