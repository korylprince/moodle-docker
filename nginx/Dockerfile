FROM golang:1.16-alpine as builder

RUN apk add --no-cache git

RUN GO111MODULE=on go get github.com/korylprince/fileenv@v1.1.0

# build image
FROM alpine:3.13

ARG VERSION

COPY --from=builder /go/bin/fileenv /

RUN apk add --no-cache git nginx

RUN git clone --branch "$VERSION" --single-branch --depth 1 \
    git://git.moodle.org/moodle.git /moodle

RUN mkdir -p  /run/nginx && \
    sed -i -e "s/user nginx/user root/" /etc/nginx/nginx.conf && \
    ln -sfT /dev/stdout /var/log/nginx/access.log && \
    ln -sfT /dev/stderr /var/log/nginx/error.log

COPY default.conf /etc/nginx/conf.d/
COPY run.sh /

CMD ["/fileenv", "/run.sh"]
