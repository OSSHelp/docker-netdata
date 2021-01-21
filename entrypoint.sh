#!/bin/bash

hostname=$(hostname)
host_ip=$(ip r | awk '/^def/{print $3}')

sed -i "s/NETDATA_HOSTNAME/${NETDATA_HOSTNAME:-$hostname}/" /etc/netdata/netdata.conf
sed -i "s/NETDATA_MASTER_HOST/${NETDATA_MASTER_HOST:-$host_ip}/" /etc/netdata/stream.conf
sed -i "s/NETDATA_MASTER_API_KEY/$NETDATA_MASTER_API_KEY/" /etc/netdata/stream.conf

for plugin in $(env | awk -F'=' '{print $1}' | grep 'NETDATA_PLUGIN_' | sed 's/NETDATA_PLUGIN_//g'); do
  echo "${plugin,,}: yes" >> /etc/netdata/python.d.conf
  env_var="NETDATA_PLUGIN_$plugin"
  # shellcheck disable=SC2039
  echo "jobs: [${!env_var}]" > /tmp/plugin.yml
  j2 -f yaml /etc/netdata/plugin_template.j2 /tmp/plugin.yml > "/etc/netdata/python.d/${plugin,,}.conf"
done

if [ -z "$1" ]; then
		test -n "$NETDATA_START_DELAY" && sleep "$NETDATA_START_DELAY"
        set -- /usr/sbin/run.sh
fi

exec "$@"
