#!/bin/bash
set -e

version=$1

phptag="korylprince/moodle-docker-php"
nginxtag="korylprince/moodle-docker-nginx"

docker build --no-cache --build-arg "VERSION=$version" --tag "$phptag:$version" ./php-fpm

docker push "$phptag:$version"

if [ "$2" = "latest" ]; then
    docker tag "$phptag:$version" "$phptag:latest"
    docker push "$phptag:latest"
fi

docker build --no-cache --build-arg "VERSION=$version" --tag "$nginxtag:$version" ./nginx

docker push "$nginxtag:$version"

if [ "$2" = "latest" ]; then
    docker tag "$nginxtag:$version" "$nginxtag:latest"
    docker push "$nginxtag:latest"
fi
