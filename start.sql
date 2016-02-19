drop database if exists experimenthub;
create database experimenthub;
grant all privileges on experimenthub.* to 'hubuser'@'%' identified by 'MYSQL_REMOTE_PASSWORD' with grant option;
flush privileges;
