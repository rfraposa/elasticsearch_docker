#!/bin/bash

rm -rf /home/elastic/.ssh/known_hosts

#Start the containers
echo "Starting $1 servers..."
for (( i=1; i<=$1; ++i));
do
ip=$((i+1))
CID=$(docker run -d --restart always --privileged --dns 8.8.8.8  --name server$i -h server$i --publish-all=true -d  --net=es_bridge --ip 172.18.0.$ip -p 9200:9200  -i -t elastic/server)
server_ip=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' server$i)
echo "Started server$i on IP $server_ip"
done

echo "Starting the database server"
docker run --restart always --privileged --dns 8.8.8.8 --name db_server -h db_server --ip 172.18.0.30  --net=es_bridge -e POSTGRES_PASSWORD=password -d elastic/db_server
server_ip=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' db_server)
echo "Database server running on IP $server_ip"
