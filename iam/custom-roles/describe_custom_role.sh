#!/bin/sh

PROJECT=$(gcloud config get-value project)
gcloud iam roles describe custom.iamViewer --project $PROJECT
