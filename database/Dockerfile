FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

# Install MySQL and update bind-address
RUN apt-get update && \
    apt-get install -y mysql-server && \
    sed -i 's/^bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf && \
    apt-get clean

COPY init.sql /init.sql

EXPOSE 3306

CMD bash -c '\
    service mysql start && \
    echo "Waiting for MySQL..." && \
    until mysqladmin ping --silent; do sleep 3; done && \
    mysql -u root < /init.sql && \
    tail -f /dev/null'

#-----------------------------------------------------

#Build using mysql image directly
#FROM mysql:8.0
#ENV MYSQL_ROOT_PASSWORD=root
#ENV MYSQL_DATABASE=chatappdb
#ENV MYSQL_USER=arpit
#ENV MYSQL_PASSWORD=Jodhpur@21

#COPY init.sql /docker-entrypoint-initdb.d/ 
