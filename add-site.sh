#!/bin/bash

echo Usage: addsite.sh example.com backup@server:example.com email@forward.com app
echo script under construction, do not use.
exit

mkdir -p /data/domains/$1/TLS
cd /data/domains/$1
git init
git remote add origin $1
# run app init
# start the backend
# add domain to approved-certs, haproxy.cfg, crt-list, --link in /data/haproxy and restart
# add domain to destinations, forwards in /data/postfix and restart
