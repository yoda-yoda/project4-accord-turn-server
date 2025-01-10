# Use Go 1.23 base image
FROM golang:1.23-alpine

# Set the working directory
WORKDIR /app

# Copy go.mod and go.sum files
COPY go.mod go.sum ./

# Download dependencies
RUN go mod download

# Copy the source code
COPY . .

# Build the application
RUN go build -o simple_turn

# Command to run the application
CMD ["./simple_turn", "-public-ip", "127.0.0.1", "-users", "user1=pass1"]
