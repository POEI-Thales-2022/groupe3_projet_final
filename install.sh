#!/bin/sh
set -e
(
    cd terraform
    terraform plan -out plan
    terraform apply plan
)
(
    cd ansible
    ./setup-k8s.sh
    ./setup-gitlab.sh
)
