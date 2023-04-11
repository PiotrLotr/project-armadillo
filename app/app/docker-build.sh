#!/bin/bash

docker build --build-arg MONGO_INITDB_ROOT_USERNAME=$(grep MONGO_INITDB_ROOT_USERNAME ../.secrets | cut -d '=' -f2) \
             --build-arg MONGO_INITDB_ROOT_PASSWORD=$(grep MONGO_INITDB_ROOT_PASSWORD ../.secrets | cut -d '=' -f2) \
             --build-arg MONGO_INITDB_DATABASE=$(grep MONGO_INITDB_DATABASE ../.secrets | cut -d '=' -f2) \
             --no-cache \
             -t app_test:latest .

