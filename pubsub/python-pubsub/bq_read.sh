#!/bin/sh

# make ds
bq --location=US mk --dataset --default_table_expiration 0 --description avro forseti-security-new:dataset

# make bucket
gsutil mb gs://forseti-security-new-gcs
gsutil cp *.avro gs://forseti-security-new-gcs/

# make table
bq mk --table --description avro --label "key:value" forseti-security-new:dataset.callers2 myschema.json

# load data
bq --location=US load --source_format=AVRO dataset.callers2 "gs://forseti-security-new-gcs/*.avro"