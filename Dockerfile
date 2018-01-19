#Base image for the certification machines
FROM centos:7
LABEL maintainer "Rich Raposa <rich.raposa@elastic.co>"

#Install and configure a JDK
ENV PATH /home/elastic/bin:$PATH
ENV JAVA_HOME /usr/lib/jvm/jre-1.8.0-openjdk

RUN yum install -y java-1.8.0-openjdk-headless unzip which 

RUN groupadd -g 1000 elastic && \
    adduser -u 1000 -g 1000 elastic

#Install needed applications
RUN yum install -y python-setuptools python-setuptools-devel iproute
RUN easy_install supervisor
RUN yum -y install openssh-server  openssh-clients
RUN yum install -y postgresql

WORKDIR /home/elastic

USER 1000

#Setup sshd so users can ssh between Docker containers
USER root
RUN ssh-keygen -t rsa -N "" -f /etc/ssh/ssh_host_key \
    && ssh-keygen -t rsa -N "" -f /etc/ssh/ssh_host_rsa_key \
    && ssh-keygen -t rsa -N "" -f /etc/ssh/ssh_host_ecdsa_key \
    && ssh-keygen -t rsa -N "" -f /etc/ssh/ssh_host_ed25519_key \
    && ssh-keygen -t rsa -N "" -f /etc/ssh/ssh_host_dsa_key

RUN mkdir /home/elastic/.ssh
COPY conf/id_rsa /home/elastic/.ssh/id_rsa
COPY conf/id_rsa.pub /home/elastic/.ssh/id_rsa.pub
COPY conf/sshd_config /etc/ssh/
COPY conf/hosts	 /etc/

RUN touch /home/elastic/.ssh/authorized_keys \
    && cat /home/elastic/.ssh/id_rsa.pub >> /home/elastic/.ssh/authorized_keys \
    && chmod -R 600 /home/elastic/.ssh/id_* \
    && chown -R elastic:elastic /etc/ssh/ \
    && chown -R elastic:elastic /home/elastic/

RUN mkdir -p /etc/supervisor/conf.d
COPY conf/supervisord.conf /etc/supervisor/supervisord.conf
RUN mkdir -p /root/start-scripts/
COPY scripts/ /root/start-scripts/

RUN echo "elastic:password" | chpasswd
EXPOSE 22 
COPY conf/startup.sh /root/

# Download and extract Elastic Stack components
RUN curl -O https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.1.2.tar.gz 
RUN curl -O https://artifacts.elastic.co/downloads/logstash/logstash-6.1.2.tar.gz 
RUN curl -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.1.2-linux-x86_64.tar.gz
RUN curl -O https://artifacts.elastic.co/downloads/packs/x-pack/x-pack-6.1.2.zip 

RUN chown -R elastic:elastic /home/elastic/*

RUN tar zxf  elasticsearch-6.1.2.tar.gz && rm elasticsearch-6.1.2.tar.gz
RUN tar zxf  logstash-6.1.2.tar.gz && rm logstash-6.1.2.tar.gz
RUN tar zxf  filebeat-6.1.2-linux-x86_64.tar.gz && rm filebeat-6.1.2-linux-x86_64.tar.gz


# Download the Postgres JDBC driver for Logstash
RUN curl -O http://central.maven.org/maven2/postgresql/postgresql/9.1-901-1.jdbc4/postgresql-9.1-901-1.jdbc4.jar
RUN export PGHOST=db_server
RUN export PGUSER=postgres



CMD ["/root/startup.sh"]

