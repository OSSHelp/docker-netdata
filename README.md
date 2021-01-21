# netdata

[![Build Status](https://drone.osshelp.ru/api/badges/docker/netdata/status.svg)](https://drone.osshelp.ru/docker/netdata)

## Description

Based on the [official netdata image](https://hub.docker.com/r/netdata/netdata/) with custom configs, an entrypoint script and a healthcheck added.

## Deploy example

``` yaml
netdata:
  image: oss.help/pub/netdata:stable
  environment:
    NETDATA_HOSTNAME: somehostname
    NETDATA_MASTER_API_KEY: $NETDATA_API_KEY
    NETDATA_PLUGIN_MEMCACHED: "{name: memcached, host: memcached, port: '11211'}"
    NETDATA_PLUGIN_MYSQL: "{name: mysql, host: mysql, user: netdata, pass: $MYSQL_NETDATA_PASSWORD, port: 3306}"
    NETDATA_PLUGIN_MONGODB: "{name: mongo, host: mongo, authdb: admin, user: $MONGO_ROOT_USER, pass: $MONGO_ROOT_PASSWORD}"
    NETDATA_PLUGIN_NGINX: "{name: nginx, url: 'http://nginx/nginx_status'}"
    NETDATA_PLUGIN_PHPFPM: "{name: phpfpm, url: 'http://nginx/fpm-status?full&json'}"
    NETDATA_PLUGIN_POSTGRES: "{name: postgres, host: postgres, port: 5432, database: postgres, user: netdata, password: $POSTGRES_NETDATA_PASSWORD}"
    NETDATA_PLUGIN_REDIS: "{name: redis, host: redis, port: 6379}, {name: redis2, host: redis2, port: 6379}"
    NETDATA_PLUGIN_RETHINKDBS: "{name: rethinkdb, host: rethinkdb, port: 28015, user: $RETHINKDB_USER, password: '$RETHINKDB_PASSWORD'}"
  networks:
    - net
```

Any Python.d plugin is supported by that image.

## Links

- [official image](https://hub.docker.com/r/netdata/netdata)
- [official documentation](https://docs.netdata.cloud/packaging/docker/#install-netdata-with-docker)

## TODO

- weblog support
