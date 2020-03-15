#!/bin/sh

PROJECT=$(gcloud config get-value project)
gcloud iam list-testable-permissions //cloudresourcemanager.googleapis.com/projects/$PROJECT > testable.permissions
