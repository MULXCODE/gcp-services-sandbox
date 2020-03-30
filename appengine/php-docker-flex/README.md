# App Engine Flexible Hello World for PHP

This folder contains the sample code for running a Hello World application
on [App Engine Flexible][flex-helloworld]

[flex-helloworld]: https://cloud.google.com/appengine/docs/flexible/php/quickstart

```bash
composer install
# run
php -S localhost:8080 -t web/
```

* Execute in Docker

```bash
docker build -t myapp .
docker run -p 127.0.0.1:8080:8080 -t -i myapp
```

```bash
mysql -ugarrett -p -h 127.0.0.1 --port 3306
```

## Create Cloud SQL - MySQL Database

```bash
# 1. Enable Private Services Access on the Shared VPC Project
# https://cloud.google.com/sql/docs/mysql/configure-private-services-access

# 2. Create Cloud SQL, MySQL 5.7 database
# Attach this to the Shared VPC Network
# Note the connection string

# 3. Create a Debian Bastion Host / Jumpbox, download `cloud_sql_proxy` for Linux
# Use `cloud_sql_proxy` to connect via TCP ports
## ./bastion-host-ssh (executed ON the bastion host)
sudo apt-get update;
sudo apt-get install -y mysql-client
wget https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64 -O cloud_sql_proxy
chmod +x cloud_sql_proxy
INSTANCE_CONNECTION_NAME="elevated-watch-270607:us-central1:mysql"
./cloud_sql_proxy -instances=$INSTANCE_CONNECTION_NAME=tcp:3306 &

mysql -uroot -p -h 127.0.0.1
### ./mysql-cli (this code is executed in the mysql cli session)
SHOW DATABASES;
CREATE DATABASE php_docker_flex;

USE php_docker_flex;
CREATE TABLE pet (name VARCHAR(20), owner VARCHAR(20),
       species VARCHAR(20), sex CHAR(1), birth DATE, death DATE);
INSERT INTO pet VALUES('Terrence', 'Brian', 'Mystery', '2', '2000-01-01', null);
SELECT * FROM pet;
### ./end mysql-cli

## ./bastion-host-ssh



```
