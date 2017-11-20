#!/bin/bash

rm -rf /home/elastic/.ssh/known_hosts

#Start the containers
echo "Starting $1 WorkerNodes..."
for (( i=1; i<=$1; ++i));
do
ip=$((i+1))
CID=$(docker run -d --restart always --privileged --dns 8.8.8.8 --name node$i -h node$i --publish-all=true -d  --net=es_bridge --ip 172.18.0.$ip  -i -t elastic/cert)
IP_node=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' node$i)
echo "Started node$i on IP $IP_node"
done
