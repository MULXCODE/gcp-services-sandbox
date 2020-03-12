#!/bin/sh

docker build -t myimage1:1.0 .

docker images

docker run $(docker images --filter=reference=myimage1 --format "{{.ID}}")
