#!/bin/sh
set -e

# get vars
source ./make-vars.sh

# open tunnel
az network bastion tunnel -g $RESOURCE_GROUP -n bastion \
    --target-resource-id $GITLAB_RID --port 8022 --resource-port 22 &
TUN=$!
sleep 5
untunnel() {
    kill $TUN
}
trap untunnel EXIT

# ansible playbooks
ansible-playbook gitlab.yml -i general-inventory.ini -e '@vars.yml' \
    --private-key "$SSH_KEY_PATH"
