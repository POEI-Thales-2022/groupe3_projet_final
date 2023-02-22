#!/bin/sh

# get vars
source ./make-vars.sh || exit 1

# setup Python
python -m venv .env
source .env/bin/activate
pip install ansible

# ansible playbooks
ansible-playbook gitlab.yml -i others-inventory.ini -e '@vars.yml' \
    --private-key "$SSH_KEY_PATH"
