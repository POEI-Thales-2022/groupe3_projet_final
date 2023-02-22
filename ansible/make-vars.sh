#!/bin/bash

# environment variables
export KUBESPRAY_VERSION=2.21.0
export SSH_KEY_PATH="$HOME/.ssh/projetfinal"
cd ../terraform
export GITLAB_IP="`terraform output -raw gitlab_ip`"
export GITLAB_FQDN="`terraform output -raw gitlab_dns_name`"
export K8S_MAIN_IP="`terraform output -raw k8s_main_private_ip`"
export K8S_WORKER_IP="`terraform output -raw k8s_worker_private_ip`"
export K8S_MAIN_PUBLIC_IP="`terraform output -raw k8s_main_public_ip`"
export K8S_WORKER_PUBLIC_IP="`terraform output -raw k8s_worker_public_ip`"
cd -

# checks
[ -f "$SSH_KEY_PATH" ] || (
    echo "please get the project’s ssh key"
    exit 1
)

# ansible YAML variables file
cat > vars.yml << EOF
k8s_main_ip: $K8S_MAIN_IP
k8s_worker_ip: $K8S_WORKER_IP
gitlab_ip: $GITLAB_IP
gitlab_fqdn: $GITLAB_FQDN
EOF

# ansible inventory file
# note: KubeSpray’s inventory is created in setup-k8s.sh
cat > general-inventory.ini << EOF
[k8s]
k8s-main ansible_host=$K8S_MAIN_PUBLIC_IP
k8s-worker ansible_host=$K8S_WORKER_PUBLIC_IP

[gitlabs]
gitlab ansible_host=$GITLAB_IP
EOF
