#!/bin/sh
python -m venv .env
source .env/bin/activate
pip install ansible-playbook
./make-vars.sh
ansible-playbook gitlab.yml -e '@vars.yml'
