#Docker image for node2
FROM elastic/eng2
LABEL maintainer "Rich Raposa <rich.raposa@elastic.co>"

COPY elasticsearch.yml /home/elastic/elasticsearch/config/
COPY jvm.options /home/elastic/elasticsearch/config/

RUN chown -R elastic:elastic /home/elastic/elasticsearch/config/

CMD ["/root/startup.sh"]

