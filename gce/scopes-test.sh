#!/bin/sh

PROJECT_ID=${1:-"your-project-id"}

gcloud beta compute \
--project=$PROJECT_ID instances create scopes-compute \
--zone=us-central1-a --machine-type=n1-standard-1 \
--subnet=default --network-tier=PREMIUM --maintenance-policy=MIGRATE \
--image=debian-9-stretch-v20200210 --image-project=debian-cloud --boot-disk-size=10GB \
--boot-disk-type=pd-standard --boot-disk-device-name=scopes-test --reservation-affinity=any \
--service-account=project-service-account@$PROJECT_ID.iam.gserviceaccount.com \
--scopes=https://www.googleapis.com/auth/compute

gcloud beta compute \
--project=$PROJECT_ID instances create scopes-storage \
--zone=us-central1-a --machine-type=n1-standard-1 \
--subnet=default --network-tier=PREMIUM --maintenance-policy=MIGRATE \
--image=debian-9-stretch-v20200210 --image-project=debian-cloud --boot-disk-size=10GB \
--boot-disk-type=pd-standard --boot-disk-device-name=scopes-test --reservation-affinity=any \
--service-account=project-service-account@$PROJECT_ID.iam.gserviceaccount.com \
--scopes=https://www.googleapis.com/auth/devstorage.read_only

gcloud beta compute \
--project=$PROJECT_ID instances create scopes-all \
--zone=us-central1-a --machine-type=n1-standard-1 \
--subnet=default --network-tier=PREMIUM --maintenance-policy=MIGRATE \
--image=debian-9-stretch-v20200210 --image-project=debian-cloud --boot-disk-size=10GB \
--boot-disk-type=pd-standard --boot-disk-device-name=scopes-test --reservation-affinity=any \
--service-account=project-service-account@$PROJECT_ID.iam.gserviceaccount.com \
--scopes=https://www.googleapis.com/auth/cloud-platform
