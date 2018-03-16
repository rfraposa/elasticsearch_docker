#Docker image for the Engineer 2 containers

FROM elastic/server
LABEL maintainer "Rich Raposa <rich.raposa@elastic.co>"

WORKDIR /home/elastic

# Download and extract Logstash for the Entity Modeling lab
RUN curl -O https://artifacts.elastic.co/downloads/logstash/logstash-6.2.1.tar.gz 
RUN tar -xzf logstash-6.2.1.tar.gz && rm -rf logstash-6.2.1.tar.gz && mv logstash-6.2.1 logstash

# Download and unzip Kibana
RUN curl -O https://artifacts.elastic.co/downloads/kibana/kibana-6.2.1-linux-x86_64.tar.gz
RUN tar -zxf kibana-6.2.1-linux-x86_64.tar.gz && rm -rf kibana-6.2.1-linux-x86_64.tar.gz

#Unzip Elasticsearch and download the data folder from S3
RUN tar -xzf elasticsearch-6.2.1.tar.gz && rm -rf elasticsearch-6.2.1.tar.gz
RUN curl -O https://s3-us-west-2.amazonaws.com/training-certification/engineer2/data.zip
RUN rm -rf /home/elastic/elasticsearch-6.2.1/data/
RUN unzip -q data.zip -d /home/elastic/elasticsearch-6.2.1/

#COPY scripts/ /home/elastic/

RUN chown -R elastic:elastic /home/elastic/*

CMD ["/root/startup.sh"]

