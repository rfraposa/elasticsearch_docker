#Docker image for node3
FROM elastic/eng2
LABEL maintainer "Rich Raposa <rich.raposa@elastic.co>"

COPY elasticsearch.yml /home/elastic/elasticsearch/config/
COPY jvm.options /home/elastic/elasticsearch/config/

RUN chown -R elastic:elastic /home/elastic/elasticsearch/config/
RUN rm -rf kibana* && rm -rf logstash*

CMD ["/root/startup.sh"]

