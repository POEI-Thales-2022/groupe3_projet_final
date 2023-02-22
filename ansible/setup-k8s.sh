#!/bin/sh
KUBESPRAY_VERSION=2.21.0
SSH_KEY_PATH="$HOME/.ssh/projetfinal"

# checks
[ -f "$SSH_KEY_PATH" ] || (
    echo "please get the project’s ssh key"
    exit 1
)

# get ips
cd ../terraform
K8S_MAIN_PUBLIC_IP="`terraform output -raw k8s_main_public_ip`"
K8S_MAIN_PRIVATE_IP="`terraform output -raw k8s_main_private_ip`"
K8S_WORKER_PUBLIC_IP="`terraform output -raw k8s_worker_public_ip`"
K8S_WORKER_PRIVATE_IP="`terraform output -raw k8s_worker_private_ip`"
cd -

# setup kubespray
KUBESPRAY_PATH="kubespray-$KUBESPRAY_VERSION"
[ -d "$KUBESPRAY_PATH" ] || \
    curl -L "https://github.com/kubernetes-sigs/kubespray/archive/refs/tags/v$KUBESPRAY_VERSION.tar.gz" | \
    tar xz
cd "$KUBESPRAY_PATH"
python -m venv .env
source .env/bin/activate
pip install -r requirements.txt
python contrib/inventory_builder/inventory.py \
    "$K8S_MAIN_PRIVATE_IP,$K8S_MAIN_PUBLIC_IP" \
    "$K8S_WORKER_PRIVATE_IP,$K8S_WORKER_PUBLIC_IP"
ansible-playbook -i inventory/sample/hosts.yaml cluster.yml -b -v \
    --private-key="$SSH_KEY_PATH" --user adminuser
