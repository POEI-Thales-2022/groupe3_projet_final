#!/bin/sh
(
    cd terraform
    terraform plan -out plan
    terraform apply plan
)
(
    cd ansible
    ./setup-k8s.sh
    ./setup-others.sh
)