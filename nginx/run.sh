#!/bin/sh

sed -i -e "s/{remote}/$FASTCGI_REMOTE/" /etc/nginx/http.d/default.conf

nginx -g "daemon off;"
