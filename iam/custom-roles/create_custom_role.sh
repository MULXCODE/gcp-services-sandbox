#!/bin/sh

PROJECT=$(gcloud config get-value project)
gcloud iam roles create custom.iamViewer --file custom-role-binding.yaml --project $PROJECT 
