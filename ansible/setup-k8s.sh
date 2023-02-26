#!/bin/sh
set -e

# set vars
source ./make-vars.sh

# open tunnels
az network bastion tunnel -g $RESOURCE_GROUP -n bastion \
    --target-resource-id $K8S_MAIN_RID --port 8023 --resource-port 22 &
TUN1=$!
az network bastion tunnel -g $RESOURCE_GROUP -n bastion \
    --target-resource-id $K8S_WORKER_RID --port 8024 --resource-port 22 &
TUN2=$!
sleep 5
untunnel() {
    kill $TUN1 $TUN2
}
trap untunnel EXIT

# run pre-spray playbook
ansible-playbook -i general-inventory.ini pre-kubespray.yml \
    --private-key "$SSH_KEY_PATH"

# make inventory
cat > spray-inventory.ini << EOF
[all]
k8s-main ansible_host=localhost ip=$K8S_MAIN_IP ansible_port=8023 etcd_member_name=etcd1
k8s-worker ansible_host=localhost ip=$K8S_WORKER_IP ansible_port=8024 etcd_member_name=etcd2

[kube_control_plane]
k8s-main

[etcd]
k8s-main

[kube_node]
k8s-worker

[calico_rr]

[k8s_cluster:children]
kube_control_plane
kube_node
calico_rr
EOF

# setup kubespray
KUBESPRAY_PATH="kubespray-$KUBESPRAY_VERSION"
[ -d "$KUBESPRAY_PATH" ] || \
curl -L "https://github.com/kubernetes-sigs/kubespray/archive/refs/tags/v$KUBESPRAY_VERSION.tar.gz" | \
    tar xz
cd "$KUBESPRAY_PATH"
python -m venv .env
source .env/bin/activate
pip install -r requirements.txt
# ansible-playbook -i ../spray-inventory.ini cluster.yml -b -v \
#     --private-key="$SSH_KEY_PATH" --user adminuser
