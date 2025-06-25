FROM ubuntu:22.04

RUN apt-get update && apt-get install -y mysql-server

COPY init.sql /init.sql

CMD service mysql start && mysql -u root -e "source /init.sql;" && tail -f /dev/null


