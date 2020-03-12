#!/bin/sh

## deploys forseti via terraform

GSUITE_ADMIN_EMAIL="admin@domain.com"
DOMAIN="domain.com"
PROJECT_ID="project-id"
ORG_ID="123456789"

sed "s/\[GSUITE_ADMIN_EMAIL\]/$GSUITE_ADMIN_EMAIL/; s/\[DOMAIN\]/$DOMAIN/; s/\[PROJECT_ID\]/$PROJECT_ID/; s/\[ORG_ID\]/$ORG_ID/"" main.tf
  
terraform init
terraform apply --auto-approve