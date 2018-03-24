#Docker image for node1

FROM elastic/eng2
LABEL maintainer "Rich Raposa <rich.raposa@elastic.co>"

WORKDIR /home/elastic

COPY conf/node1 /home/elastic/elasticsearch/config/

CMD ["/root/startup.sh"]

