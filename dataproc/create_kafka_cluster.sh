#!/bin/sh

PROJECT_ID=$(gcloud config get-value core/project)

gcloud iam service-accounts create dataproc-service-account
gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member=serviceAccount:dataproc-service-account@$PROJECT_ID.iam.gserviceaccount.com \
    --role=roles/dataproc.worker

gcloud dataproc clusters create \
    kafka-cluster \
    --region us-west1 \
    --num-masters 3 \
    --metadata "run-on-master=true" \
    --service-account=dataproc-service-account@$PROJECT_ID.iam.gserviceaccount.com \
    --initialization-actions gs://dataproc-initialization-actions/kafka/kafka.sh
