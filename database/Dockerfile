FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

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
