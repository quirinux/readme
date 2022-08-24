FROM rust:latest as builder
RUN mkdir /app
WORKDIR /app
COPY . .
RUN make build.release

FROM alpine:latest
RUN apk update --no-cache
RUN rm -rf /var/cache/apk/*
WORKDIR /app
COPY --from=builder /app/target/release/readme /usr/local/bin
