#BE WARNED: this script stops and deletes all servers!
docker ps | grep server | awk '{print $1}' | xargs docker stop
docker ps -a | grep server | awk '{print $1}' | xargs docker rm


