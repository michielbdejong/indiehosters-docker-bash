
#!/bin/bash

echo Generic lamp-git initialization...
sh /init/generic.sh

echo Starting server...
sh /run.sh &
sleep 10

echo "Extracting Trovebox..."
cd /data/www-content
tar xzf /init/trovebox.tgz

echo "Creating empty database..."
echo "CREATE DATABASE IF NOT EXISTS trovebox" | mysql
mysql known < /data/www-content/schemas/mysql/mysql.sql
mysqldump --all-databases > /data/dump.sql

PWD=`pwgen 40 1`
echo "user: " > /data/login.txt
echo "pass: $PWD" >> /data/login.txt
echo "Please use your browser to set up a user, and edit /data/login.txt manually:"
cat /data/login.txt
