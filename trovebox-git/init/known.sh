#!/bin/bash

echo Generic lamp-git initialization...
sh /init/generic.sh

echo Starting server...
sh /run.sh &
sleep 10

echo "Extracting Known..."
cd /data/www-content
tar xzf /init/known.tgz
mv Known-0.7/* .
mv Known-0.7/.* .
rmdir Known-0.7

echo "Setting default config..."
cp /init/config.ini .

echo "Creating empty database..."
echo "CREATE DATABASE IF NOT EXISTS known" | mysql
mysql known < /data/www-content/schemas/mysql/mysql.sql
mysqldump --all-databases > /data/dump.sql

mv /data/www-content/htaccess.dist /data/www-content/.htaccess

PWD=`pwgen 40 1`
echo "user: " > /data/login.txt
echo "pass: $PWD" >> /data/login.txt
echo "Please use your browser to set up a user, and edit /data/login.txt manually:"
cat /data/login.txt
