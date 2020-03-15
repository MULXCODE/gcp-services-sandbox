#!/bin/sh

PROJECT_ID=sandbox-0700

gcloud config set core/project $PROJECT_ID

# create 2 Gb basic tier redis
gcloud beta redis instances create myinstance --size=2 --region=us-central1

# use describe command to get ip address
HOST=$(gcloud beta redis instances describe myinstance --region=us-central1 | grep host | sed "s/host://")
PORT=$(gcloud beta redis instances describe myinstance --region=us-central1 | grep port | sed "s/port://")

echo $HOST

echo $PORT
