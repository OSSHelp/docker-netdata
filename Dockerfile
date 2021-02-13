FROM netdata/netdata:stable
# hadolint ignore=DL3018,DL3013
RUN apk add --no-cache py3-pip py-setuptools tzdata py3-mysqlclient \
    && pip3 install j2cli[yaml] rethinkdb pymongo \
    && cp /usr/share/zoneinfo/Europe/Moscow /etc/localtime \
    && echo "Europe/Moscow" > /etc/timezone \
    && apk del --no-cache py3-pip tzdata

COPY entrypoint.sh /usr/local/bin/
COPY confs/ /etc/netdata/

ENTRYPOINT ["entrypoint.sh"]

HEALTHCHECK --interval=15s --timeout=3s --start-period=15s \
  CMD curl -s localhost:19999/api/v1/info | grep -q version || exit 1
