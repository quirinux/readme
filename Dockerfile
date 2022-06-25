FROM crystallang/crystal:latest-alpine as builder
RUN mkdir /app
WORKDIR /app
COPY . .
RUN make build.release

FROM alpine:latest
RUN apk update --no-cache
RUN apk add --no-cache \
      libxml2-dev \
      pcre-dev \
      libgcc
RUN rm -rf /var/cache/apk/*
WORKDIR /app
COPY --from=builder /app/bin/readme /usr/local/bin
