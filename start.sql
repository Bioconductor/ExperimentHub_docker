drop database if exists experimenthub;
create database experimenthub;
flush privileges;
DROP USER IF EXISTS 'hubuser'@'%';
flush privileges;
CREATE USER 'hubuser'@'%' IDENTIFIED BY 'MYSQL_REMOTE_PASSWORD';
GRANT ALL PRIVILEGES ON experimenthub.* TO 'hubuser'@'%' WITH GRANT OPTION;
flush privileges;
