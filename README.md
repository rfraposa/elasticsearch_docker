# elasticsearch_docker

To build the Docker image for the servers:

```
docker build -t elastic/server .
```

To build the Docker image for the PostgresDB server:

```
cd db_node/
docker build -t elastic/db_server .
```

To startup some servers, use the `conf/start_servers.sh` script, passing in the number of desired servers. For example:

```
conf/start_servers.sh 5
```