#We extend a postgres node that runs our SQL commands
FROM postgres
LABEL maintainer "Rich Raposa <rich.raposa@elastic.co>"

COPY conf/ /docker-entrypoint-initdb.d/

WORKDIR /home/postgres

RUN curl -O http://central.maven.org/maven2/postgresql/postgresql/9.1-901-1.jdbc4/postgresql-9.1-901-1.jdbc4.jar