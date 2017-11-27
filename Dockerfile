FROM library/golang:1.9-alpine as builder
COPY . /go/src/github.com/lebokus/docker-volume-bindfs
WORKDIR /go/src/github.com/lebokus/docker-volume-bindfs
RUN set -ex \
    && apk add --no-cache --virtual .build-deps \
    gcc libc-dev \
    && go install --ldflags '-extldflags "-static"' \
    && apk del .build-deps
CMD ["/go/bin/docker-volume-bindfs"]

FROM debian
RUN apt-get update && apt-get install bindfs -y
RUN mkdir -p /run/docker/plugins /mnt/state /mnt/volumes
COPY --from=builder /go/bin/docker-volume-bindfs .
CMD ["docker-volume-bindfs"]
