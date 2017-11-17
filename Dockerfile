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

WORKDIR /home/elastic

USER 1000

# Download and extract Elastic Stack components
RUN curl -fsSL https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.0.0.tar.gz | \
    tar zx 

#RUN curl -fsSL https://artifacts.elastic.co/downloads/kibana/kibana-6.0.0-linux-x86_64.tar.gz | \
#    tar zx 

#RUN curl -fsSL https://artifacts.elastic.co/downloads/logstash/logstash-6.0.0.tar.gz | \
#    tar zx

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

RUN touch /home/elastic/.ssh/authorized_keys \
    && cat /home/elastic/.ssh/id_rsa.pub >> /home/elastic/.ssh/authorized_keys \
    && chmod -R 600 /home/elastic/.ssh/id_* \
    && chown -R elastic:elastic /etc/ssh/ \
    && chown -R elastic:elastic /home/elastic/

#RUN sed -i  '$a /sbin/sshd' /etc/rc.local
#RUN chmod +x /etc/rc.local

RUN mkdir -p /etc/supervisor/conf.d
COPY conf/supervisord.conf /etc/supervisor/supervisord.conf
RUN mkdir -p /root/start-scripts/
COPY scripts/ /root/start-scripts/

RUN echo "elastic:elastic" | chpasswd
EXPOSE 22
COPY conf/startup.sh /root/
CMD ["/root/startup.sh"]
