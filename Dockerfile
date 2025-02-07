# Build Stage
FROM golang:1.23-alpine AS builder
WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN go build -o simple_turn

# Runtime Stage
FROM alpine:latest
RUN apk --no-cache add ca-certificates

WORKDIR /root/
COPY --from=builder /app/simple_turn .

RUN echo '#!/bin/sh' > /entrypoint.sh && \
    echo '/root/simple_turn --public-ip 172.30.1.53 --port 3478 --users "user=pass,user=pass" --realm "pion.ly"' >> /entrypoint.sh && \
    chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
