#!/bin/sh

sed -i -e "s/{remote}/$FASTCGI_REMOTE/" /etc/nginx/conf.d/default.conf

nginx -g "daemon off;"
