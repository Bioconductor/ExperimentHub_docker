#!/bin/sh

if [ -z "${MYSQL_REMOTE_PASSWORD}" ]; then
    echo "MYSQL_REMOTE_PASSWORD is not set; exiting!"
    echo "(see README.md)"
    exit 1
fi

cd /tmp

echo get database from master
mysqldump --lock-tables=false --password=$MYSQL_REMOTE_PASSWORD -u hubuser_readonly -h experimenthub.bioconductor.org experimenthub | gzip > /tmp/dump.sql.gz

echo create local database and user
cat /tmp/start.sql | sed "s/MYSQL_REMOTE_PASSWORD/$MYSQL_REMOTE_PASSWORD/" |  mysql -u root --password=$MYSQL_ROOT_PASSWORD -h db

echo populate local database
zcat /tmp/dump.sql.gz | mysql -u root --password=$MYSQL_ROOT_PASSWORD -h db experimenthub

curl http://experimenthub.bioconductor.org:3000/metadata/experimenthub.sqlite3 > /HubServer/experimenthub.sqlite3

cd /HubServer

cat /tmp/config.yml | sed "s/MYSQL_REMOTE_PASSWORD/$MYSQL_REMOTE_PASSWORD/" > config.yml

echo start app
#ruby app.rb
shotgun -o 0.0.0.0 -p 3000 app.rb

sleep infinity
