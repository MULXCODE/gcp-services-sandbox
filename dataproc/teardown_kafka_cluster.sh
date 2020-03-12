#!/bin/sh

gcloud dataproc clusters delete \
    kafka-cluster \
    --region us-west1