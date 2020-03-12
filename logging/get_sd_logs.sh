#!/bin/sh

gcloud logging read "service" --freshness=10d
