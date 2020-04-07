#!/bin/sh

docker pull gcr.io/cloudsql-docker/gce-proxy:1.16

# create service account
gcloud iam service-accounts keys create sa-key.json --iam-account 385888284430-compute@developer.gserviceaccount.com
