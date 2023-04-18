FROM golang:1.16-alpine

ENV VERIFIER_SECRET_KEY='TopSecretKey'
EXPOSE 3005

# Set working directory
WORKDIR /app

# Install dependencies
# Musl-dev is required to fix stdlib.h
RUN apk update && apk add --no-cache wget git gcc musl-dev make sqlite 
RUN apk add --no-cache curl \     
  && curl -L https://github.com/golang-migrate/migrate/releases/download/v4.15.2/migrate.linux-armv7.tar.gz | tar xzv \
  && mv migrate /usr/local/bin/migrate \     
  && apk del curl

# Pull source code
RUN git clone https://github.com/oxtyped/gpodder2go.git /app/gpodder2go

# Make
RUN cd /app/gpodder2go && make build

# Init
RUN cd gpodder2go && ./gpodder2go init

# Run
CMD ["sh", "-c", "echo $VERIFIER_SECRET_KEY && cd /app/gpodder2go && ./gpodder2go serve -b 0.0.0.0:80"]