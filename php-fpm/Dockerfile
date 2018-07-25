FROM golang:1.10-alpine as builder

RUN apk add --no-cache git

RUN git clone --branch "v1.1" --single-branch --depth 1 \
    https://github.com/korylprince/fileenv.git /go/src/github.com/korylprince/fileenv

RUN git clone --branch "v1.0" --single-branch --depth 1 \
    https://github.com/korylprince/run-every.git /go/src/github.com/korylprince/run-every

RUN go install github.com/korylprince/fileenv
RUN go install github.com/korylprince/run-every

# build image
FROM alpine:3.8

ARG VERSION

COPY --from=builder /go/bin/fileenv /
COPY --from=builder /go/bin/run-every /

RUN apk add --no-cache git php7-cli php7-fpm \
    php7-ctype \
    php7-curl \
    php7-dom \
    php7-fileinfo \
    php7-gd \
    php7-iconv \
    php7-intl \
    php7-json \
    php7-ldap \
    php7-mbstring \
    php7-mysqli \
    php7-opcache \
    php7-openssl \
    php7-session \
    php7-simplexml \
    php7-soap \
    php7-tokenizer \
    php7-xml \
    php7-xmlreader \
    php7-xmlrpc \
    php7-zip \
    aspell ghostscript graphviz python

RUN git clone --branch "$VERSION" --single-branch --depth 1 \
    git://git.moodle.org/moodle.git /moodle && \
    chown nobody:nobody /moodle

COPY www.conf /etc/php7/php-fpm.d/
COPY config.php /moodle/

RUN sed -i -e "s/upload_max_filesize = 2M/upload_max_filesize = 10G/" /etc/php7/php.ini && \
    sed -i -e "s/post_max_size = 8M/post_max_size = 10G/" /etc/php7/php.ini && \
    sed -i -e "s/max_execution_time = 30/max_execution_time = 3600/" /etc/php7/php.ini && \
    sed -i -e "s/memory_limit = 128M/memory_limit = 1024M/" /etc/php7/php.ini

RUN mkdir /moodledata && chown nobody:nobody /moodledata

COPY run.sh /

CMD ["/fileenv", "/run.sh"]
