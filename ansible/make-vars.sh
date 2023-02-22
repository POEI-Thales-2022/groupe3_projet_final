#!/bin/bash
cd ../terraform
export GITLAB_IP="`terraform output -raw gitlab_ip`"
export GITLAB_FQDN="`terraform output -raw gitlab_dns_name`"
export K8S_MAIN_IP="`terraform output -raw k8s_main_private_ip`"
export K8S_WORKER_IP="`terraform output -raw k8s_worker_private_ip`"
export K8S_MAIN_PUBLIC_IP="`terraform output -raw k8s_main_public_ip`"
export K8S_WORKER_PUBLIC_IP="`terraform output -raw k8s_worker_public_ip`"
cd -

cat > vars.yml << EOF
k8s_main_ip: $K8S_MAIN_IP
k8s_worker_ip: $K8S_WORKER_IP
gitlab_ip: $GITLAB_IP
gitlab_fqdn: $GITLAB_FQDN
EOF
