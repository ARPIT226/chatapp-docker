CREATE DATABASE chatappdb;

CREATE USER 'arpit'@'%' IDENTIFIED BY 'Jodhpur@21';

GRANT ALL PRIVILEGES on chatappdb.* TO 'arpit'@'%';

FLUSH PRIVILEGES;
