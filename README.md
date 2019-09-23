# docker-puppetboard

Puppetboard and pypuppetdb in a container.

* Puppetboard 1.1.0
* PyPuppetDB 1.2.0
* Python 3.6
* GUnicorn 19.7.1

## Example

```bash
$ docker run -it -p 9080:80 -v /etc/puppetlabs/puppet/ssl:/etc/puppetlabs/puppet/ssl \
-e PUPPETDB_HOST=localhost  \
-e PUPPETDB_PORT=8081 \
-e PUPPETDB_SSL_VERIFY=/etc/puppetlabs/puppetdb/ssl/ca.pem \
-e PUPPETDB_KEY=/etc/puppetlabs/puppetdb/ssl/private.pem \
-e PUPPETDB_CERT=/etc/puppetlabs/puppetdb/ssl/public.pem \
-e INVENTORY_FACTS='Hostname,fqdn, IP Address,ipaddress' \
-e ENABLE_CATALOG=True \
-e GRAPH_FACTS='architecture,puppetversion,osfamily' \
mpepping/puppetboard
```

## Environment variables

See <https://github.com/voxpupuli/puppetboard#settings> for a detailed explanation.

```text
PUPPETDB_HOST ('puppetdb')
PUPPETDB_PORT ('8080')
SSL_VERIFY (True)
PUPPETDB_KEY ('PUPPETDB_KEY', None)
PUPPETDB_CERT ('PUPPETDB_CERT', None)
PUPPETDB_PROTO ('PUPPETDB_PROTO', None)
PUPPETDB_TIMEOUT ('20'))
DEFAULT_ENVIRONMENT ('production')
SECRET_KEY (os.urandom(24))
DEV_LISTEN_HOST ('127.0.0.1')
DEV_LISTEN_PORT ('5000'))
DEV_COFFEE_LOCATION ('coffee')
UNRESPONSIVE_HOURS ('2'))
ENABLE_QUERY (True)
LOCALISE_TIMESTAMP
LOGLEVEL ('info')
NORMAL_TABLE_COUNT ('100'))
LITTLE_TABLE_COUNT ('10'))
OFFLINE_MODE (False)
ENABLE_CATALOG (False)
OVERVIEW_FILTER = (None)
PAGE_TITLE = ('Puppetboard')
GRAPH_FACTS_DEFAULT = ','.join(['architecture', 'clientversion', 'domain',
                                'lsbcodename', 'lsbdistcodename', 'lsbdistid',
                                'lsbdistrelease', 'lsbmajdistrelease',
                                'netmask', 'osfamily', 'puppetversion',
                                'processorcount'])
GRAPH_FACTS ('GRAPH_FACTS_DEFAULT).split(','))
GRAPH_TYPE ('pie')
REFRESH_RATE ('30')
DAILY_REPORTS_CHART_ENABLED (True)
DAILY_REPORTS_CHART_DAYS ('8')
```
