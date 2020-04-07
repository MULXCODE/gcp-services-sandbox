#!/bin/sh

INSTANCE_CONNECTION_NAME="elevated-watch-270607:us-central1:mysql-public"

docker run -d \
  -v /Users/garrettwong/Git/gcp-services-sandbox/cloudsql/cloud_sql_proxy_docker:/config \
  -p 127.0.0.1:3306:3306 \
gcr.io/cloudsql-docker/gce-proxy:1.16 /cloud_sql_proxy \
  -instances=$INSTANCE_CONNECTION_NAME=tcp:0.0.0.0:3306 -credential_file=/config/sa-key.json
