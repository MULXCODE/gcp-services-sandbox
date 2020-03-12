#!/bin/sh

# Copyright 2020 Google LLC. 
# This software is provided as-is
# without warranty or representation for any use or purpose. 
# Your use of it is subject to your agreement with Google.  

BILLING_ACCOUNT_ID=$(gcloud alpha billing accounts list --filter="open = True" --format="get(name)" | sed 's/billingAccounts\///')

for i in {1..10}
do
    PROJECT_ID="svc-account-limits-$i"
    
    gcloud projects create $PROJECT_ID 
    
    gcloud beta billing projects link $PROJECT_ID \
        --billing-account=$BILLING_ACCOUNT_ID

    gcloud services enable compute.googleapis.com --project $PROJECT_ID
done

