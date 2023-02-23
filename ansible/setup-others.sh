#!/bin/sh

# get vars
source ./make-vars.sh || exit 1

# ansible playbooks
ansible-playbook gitlab.yml -i general-inventory.ini -e '@vars.yml' \
    --private-key "$SSH_KEY_PATH"
