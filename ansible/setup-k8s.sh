#!/bin/sh
KUBESPRAY_VERSION=2.21.0
SSH_KEY_PATH="$HOME/.ssh/projetfinal"

# checks
[ -f "$SSH_KEY_PATH" ] || (
    echo "please get the project’s ssh key"
    exit 1
)

# set vars
source make-vars.sh

# make inventory
cat > inventory.ini << EOF
[all]
k8s-main ansible_host=$K8S_MAIN_PUBLIC_IP ip=$K8S_MAIN_IP etcd_member_name=etcd1
k8s-worker ansible_host=$K8S_WORKER_PUBLIC_IP ip=$K8S_WORKER_IP etcd_member_name=etcd2

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
[ -d "$KUBESPRAY_PATH" ] && rm -rf "$KUBESPRAY_PATH"
curl -L "https://github.com/kubernetes-sigs/kubespray/archive/refs/tags/v$KUBESPRAY_VERSION.tar.gz" | \
    tar xz
cd "$KUBESPRAY_PATH"
python -m venv .env
source .env/bin/activate
pip install -r requirements.txt
ansible-playbook ../k8s-set-hosts.yml -e '@../vars.yml'
ansible-playbook -i ../inventory.ini cluster.yml -b -v \
    --private-key="$SSH_KEY_PATH" --user adminuser
