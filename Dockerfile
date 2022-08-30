FROM rust:latest as builder
RUN mkdir /app
WORKDIR /app
COPY . .
RUN make build.release.x86_64

FROM alpine:latest
RUN apk update --no-cache
RUN rm -rf /var/cache/apk/*
RUN apk add libc6-compat \
  libgcc \
  gcompat


WORKDIR /app
COPY --from=builder /app/target/release/readme /usr/local/bin
ENTRYPOINT /app
CMD /usr/local/bin/readme
