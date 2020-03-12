#!/bin/sh

openssl req -newkey rsa:4096 \
            -x509 \
            -sha256 \
            -days 3650 \
            -nodes \
            -out example-woprompt.crt \
            -keyout example-woprompt.key \
            -subj "/C=US/ST=California/L=CityName/O=Organization/OU=Org Unit/CN=www.example.com"
