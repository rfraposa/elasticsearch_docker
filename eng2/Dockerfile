#Docker image for the Engineer 2 containers

FROM elastic/server
LABEL maintainer "Rich Raposa <rich.raposa@elastic.co>"

WORKDIR /home/elastic

# Download necessary files
RUN curl -O https://artifacts.elastic.co/downloads/logstash/logstash-6.2.1.tar.gz 
RUN curl -O https://artifacts.elastic.co/downloads/kibana/kibana-6.2.1-linux-x86_64.tar.gz
RUN curl -O https://s3-us-west-2.amazonaws.com/training-certification/engineer2/data.zip

#This command takes forever, so run it now before unzipping anything
RUN chown -R elastic:elastic /home/elastic/*

#Unzip everything
RUN su - elastic -c 'tar -xzf logstash-6.2.1.tar.gz && rm -rf logstash-6.2.1.tar.gz && mv logstash-6.2.1 logstash'
RUN su - elastic -c 'tar -zxf kibana-6.2.1-linux-x86_64.tar.gz && rm -rf kibana-6.2.1-linux-x86_64.tar.gz && mv kibana-6.2.1-linux-x86_64 kibana'
RUN su - elastic -c 'tar -xzf elasticsearch-6.2.1.tar.gz && rm -rf elasticsearch-6.2.1.tar.gz && mv elasticsearch-6.2.1 elasticsearch'
RUN rm -rf /home/elastic/elasticsearch-6.2.1/data/
RUN su - elastic -c 'unzip -q data.zip -d /home/elastic/elasticsearch/'
RUN rm -rf /home/elastic/data.zip
RUN mv x-pack-6.2.1.zip x-pack.zip

#Install elasticsearch Python library
RUN curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py" && python get-pip.py && pip install elasticsearch && rm get-pip.py

#COPY scripts/ /home/elastic/

CMD ["/root/startup.sh"]

