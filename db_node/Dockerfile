#Elasticsearch node that contains mysql
FROM elastic/node
LABEL maintainer "Rich Raposa <rich.raposa@elastic.co>"

#Download and add the mysql repo
WORKDIR /root/
RUN yum install -y wget
RUN wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
RUN rpm -ivh mysql-community-release-el7-5.noarch.rpm
#RUN yum update 

#Install mysql
RUN yum install -y mysql-server
RUN groupadd mysql
RUN useradd -r -g mysql -s /bin/false mysql

#Initialize mysql
RUN /usr/sbin/mysqld --initialize-insecure --user=mysql

#Copy over the script to start mysqld
COPY conf/mysqld.conf /etc/supervisor/conf.d/mysqld.conf

CMD ["/root/startup.sh"]
