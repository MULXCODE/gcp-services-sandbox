#!/bin/sh

gcloud beta compute security-policies create ca-how-to-security-policy \
    --description "policy for Cloud Armor how-to topic"

gcloud beta compute security-policies rules create 1000 \
    --security-policy ca-how-to-security-policy \
    --description "Deny traffic from 192.0.2.0/24." \
    --src-ip-ranges "192.0.2.0/24" \
    --action "deny-404"

gcloud beta compute security-policies describe ca-how-to-security-policy
