#Docker image for node1
#
# node1 downloads the data folder from S3 and unzips it, so startup node1 first when starting a cluster

FROM elastic/eng2
LABEL maintainer "Rich Raposa <rich.raposa@elastic.co>"

WORKDIR /home/elastic

RUN curl -O https://s3-us-west-2.amazonaws.com/training-certification/engineer2/data.zip

RUN chown -R elastic:elastic /home/elastic/data.zip

RUN rm -rf /home/elastic/elasticsearch/data/ && su - elastic -c 'unzip -q data.zip -d /home/elastic/elasticsearch/'
RUN rm -rf /home/elastic/data.zip


COPY elasticsearch.yml /home/elastic/elasticsearch/config/
COPY jvm.options /home/elastic/elasticsearch/config/
COPY biketrip_entities.conf/home/elastic/

RUN chown -R elastic:elastic /home/elastic/elasticsearch/config/
RUN chown -R elastic:elastic /home/elastic/biketrip_entities.conf

CMD ["/root/startup.sh"]

