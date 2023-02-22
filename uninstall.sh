#!/bin/sh
cd terraform
terraform plan -destroy -out plan
terraform apply plan
