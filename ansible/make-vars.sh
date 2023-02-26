#!/bin/bash
set -e

# environment variables
export KUBESPRAY_VERSION=2.21.0
export SSH_KEY_PATH="$HOME/.ssh/projetfinal"
cd ../terraform
declare -a TERRAFORM_OUTPUTS
TERRAFORM_OUTPUTS=(`terraform output | cut -f1 -d' '`)
for LOWER in "${TERRAFORM_OUTPUTS[@]}"; do
    UPPER="${LOWER^^}"
    declare -x "$UPPER"="`terraform output -raw $LOWER`"
done
cd -

# add ssh-key
[ -z "$SSH_AUTH_SOCK" ] && eval $(ssh-agent -s)
ssh-add "$SSH_KEY_PATH"

# setup Python
python -m venv .env
source .env/bin/activate
pip install ansible

# checks
[ -f "$SSH_KEY_PATH" ] || (
    echo "please get the project’s ssh key"
    exit 1
)

# ansible YAML variables file
rm vars.yml
for LOWER in "${TERRAFORM_OUTPUTS[@]}"; do
    UPPER="${LOWER^^}"
    echo "$LOWER: ${!UPPER}" >> vars.yml
done

# ansible inventory file
# note: KubeSpray’s inventory is created in setup-k8s.sh
cat > general-inventory.ini << EOF
[gitlabs]
gitlab ansible_host=localhost ansible_port=8022

[k8s]
k8s-main ansible_host=localhost ansible_port=8023
k8s-worker ansible_host=localhost ansible_port=8024
EOF
