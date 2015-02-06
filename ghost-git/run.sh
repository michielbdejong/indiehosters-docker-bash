#!/bin/bash

if [ ! -L /app/content ]; then
  if [ -e /data/content ]; then
    rm -rf /app/content;
  else
    mv /app/content /data;
  fi
  ln -s /data/content /app/content;
fi

sh backup.sh &

cd /app && npm start --production
