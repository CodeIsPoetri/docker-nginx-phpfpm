#!/bin/sh

php-fpm7.2
nginx

pidfile_phpfpm="/run/php/php7.2-fpm.pid"
pidfile_nginx="/run/nginx.pid"

while : ; do
    if ! pgrep -F $pidfile_phpfpm > /dev/null 2>&1; then
        echo "Daemon process php-fpm7.2 died!"
        exit 1
    fi

    if ! pgrep -F $pidfile_nginx > /dev/null 2>&1; then
        echo "Daemon process nginx died!"
        exit 1
    fi

    sleep 5
done
