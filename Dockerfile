FROM python:2.7-alpine

ENV PUPPET_BOARD_VERSION="0.3.0" \
    GUNICORN_VERSION="19.7.1" \
    PUPPETBOARD_PORT="8000" \
    PUPPETBOARD_SETTINGS="docker_settings.py"

LABEL org.label-schema.maintainer="Puppet Release Team <release@puppet.com>" \
      org.label-schema.vendor="Puppet" \
      org.label-schema.url="https://github.com/puppetlabs/puppet-in-docker" \
      org.label-schema.name="Puppetboard" \
      org.label-schema.license="Apache-2.0" \
      org.label-schema.version=$PUPPET_BOARD_VERSION \
      org.label-schema.vcs-url="https://github.com/puppetlabs/puppet-in-docker" \
      org.label-schema.vcs-ref="dec6eb5f60a3803470341177e154d346e7bda015" \
      org.label-schema.build-date="2018-05-21T17:57:42Z" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.dockerfile="/Dockerfile"

RUN apk add --update curl && rm -rf /var/cache/apk/* ; \
    pip install puppetboard=="$PUPPET_BOARD_VERSION" gunicorn=="$GUNICORN_VERSION" \
    --proxy http://www-proxy.cs.kadaster.nl:8082/ \
    --trusted-host files.pythonhosted.org --trusted-host pypi.org --trusted-host pypi.python.org

EXPOSE $PUPPETBOARD_PORT

WORKDIR /var/www/puppetboard

CMD gunicorn -b 0.0.0.0:${PUPPETBOARD_PORT} --access-logfile=/dev/stdout puppetboard.app:app
# Health check
HEALTHCHECK --interval=10s --timeout=10s --retries=90 CMD \
  curl --fail -X GET localhost:8000\
  |  grep -q 'Live from PuppetDB' \
  || exit 1

COPY Dockerfile /

