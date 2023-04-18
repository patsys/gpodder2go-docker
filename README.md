Based on [github.com/oxtyped/gpodder2go/issues/12](https://github.com/oxtyped/gpodder2go/issues/12). This project periodically re-builds a docker image for this service.

You can use it like this:
```yaml
version: "2"
services:
  app:
    image: registry.gitlab.com/confusedant/gpodder2go:latest
    restart: always
    volumes:
      - '/<your path>/gpodder2go.db:/g2g.db'
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.gpodder.rule=Host(`gpodder.<your domain>`)"
```

You will need to initialise the database, and create a user manually. See the gpodder2go repository for that.