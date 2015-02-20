#!/bin/bash

cd /data
git config --local user.email "backup@indiehosters"
git config --local user.name "IndieHosters backup"
while true; do
  git add *
  git commit -am"backup `date`"
  git status
  date
  echo "Next backup in one hour..."
  sleep 3540
done
