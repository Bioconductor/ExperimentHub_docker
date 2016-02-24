#!/bin/bash

mysqldump -u root --password=$MYSQL_ROOT_PASSWORD -h db experimenthub | gzip > /data/experimenthub.sql.gz
