# Stage 1: Build 단계
FROM golang:1.23-alpine AS builder
WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN go build -o simple_turn

FROM alpine:latest
RUN apk --no-cache add ca-certificates

WORKDIR /root/
COPY --from=builder /app/simple_turn .

EXPOSE 3478/udp

CMD ["./simple_turn", "-public-ip", "127.0.0.1", "-users", "user1=pass1"]
