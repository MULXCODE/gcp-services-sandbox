#!/bin/sh

# create pubsub topic and subscription
PUBSUB_TOPIC="pubsub-topic"
PUBSUB_SUBSCRIPTION="pubsub-sub"

gcloud pubsub topics create $PUBSUB_TOPIC
gcloud pubsub subscriptions create --topic $PUBSUB_TOPIC $PUBSUB_SUBSCRIPTION


# create scheduler job
gcloud beta scheduler jobs create pubsub entry-point2 \
    --topic="$PUBSUB_TOPIC" \
    --schedule="* * * * *" \
    --description="Entry point cron job" \
    --time-zone="America/Los_Angeles"
    --message-body='{ "sender": "entry-point2"}'
