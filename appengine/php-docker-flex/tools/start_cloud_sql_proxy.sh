#!/bin/sh

INSTANCE_CONNECTION_NAME="elevated-watch-270607:us-central1:mysql"

./cloud_sql_proxy -instances=$INSTANCE_CONNECTION_NAME=tcp:3306 -ip_address_types=PRIVATE
