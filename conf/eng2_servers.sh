#!/bin/bash

rm -rf /home/elastic/.ssh/known_hosts

#Start the containers
echo "Starting 5 servers for Engineer II..."

for (( i=1; i<=3; ++i));
do
ip=$((i+1))
CID=$(docker run -d --restart always --privileged --dns 8.8.8.8  --name server$i -h server$i --publish-all=true -d  --net=es_bridge --ip 172.18.0.$ip  -v es-vol:/shared_folder -i -t elastic/node$i)
server_ip=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' server$i)
echo "Started server$i on IP $server_ip"
done

for (( i=4; i<=5; ++i));
do
ip=$((i+1))
CID=$(docker run -d --restart always --privileged --dns 8.8.8.8  --name server$i -h server$i --publish-all=true -d  --net=es_bridge --ip 172.18.0.$ip  -v es-vol:/shared_folder  -i -t elastic/eng2)
server_ip=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' server$i)
echo "Started server$i on IP $server_ip"
done
