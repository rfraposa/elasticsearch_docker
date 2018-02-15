#Docker image for server1, which has additional files downloaded on it than the other Docker containers
# It assumes the base image was built as elastic/server

FROM elastic/server
LABEL maintainer "Rich Raposa <rich.raposa@elastic.co>"

WORKDIR /home/elastic

# Download and extract Elastic Stack components
RUN curl -O https://artifacts.elastic.co/downloads/logstash/logstash-6.2.1.tar.gz 
RUN curl -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.2.1-linux-x86_64.tar.gz
RUN curl -O https://artifacts.elastic.co/downloads/kibana/kibana-6.2.1-linux-x86_64.tar.gz

#Download the web log files
RUN curl -O https://s3-us-west-2.amazonaws.com/training-certification/engineer1/blogs_logs.tar.gz
RUN tar -xf blogs_logs.tar.gz && rm blogs_logs.tar.gz

COPY scripts/ home/elastic/

RUN chown -R elastic:elastic /home/elastic/*

CMD ["/root/startup.sh"]

