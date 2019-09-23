FROM python:3.6-alpine

ENV PUPPET_BOARD_VERSION="1.1.0" \
    GUNICORN_VERSION="19.7.1" \
    PYPUPPETDB_VERSION="1.2.0" \
    PUPPETBOARD_PORT="8000" \
    PUPPETBOARD_SETTINGS="docker_settings.py"

LABEL org.label-schema.maintainer="Martijn Pepping <martijn.pepping@automiq.nl>" \
      org.label-schema.name="Puppetboard" \
      org.label-schema.license="Apache-2.0" \
      org.label-schema.version=$PUPPET_BOARD_VERSION \
      org.label-schema.schema-version="1.0" \
      org.label-schema.dockerfile="/Dockerfile"

RUN apk add --update curl && rm -rf /var/cache/apk/* ; \
    pip install puppetboard=="$PUPPET_BOARD_VERSION" gunicorn=="$GUNICORN_VERSION" pypuppetdb>="$PYPUPPETDB_VERSION"

EXPOSE $PUPPETBOARD_PORT

WORKDIR /var/www/puppetboard

CMD gunicorn -b 0.0.0.0:${PUPPETBOARD_PORT} --log-file=- puppetboard.app:app

HEALTHCHECK --interval=10s --timeout=10s --retries=90 CMD \
  curl --fail -X GET localhost:8000\
  |  grep -q 'Live from PuppetDB' \
  || exit 1

COPY Dockerfile /
