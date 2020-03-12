#!/bin/sh

docker pull jenkins

docker images

docker run --name myjenkinsx -p 8080:8080 -p 50000:50000 -v /tmp/:/var/jenkins_home jenkins