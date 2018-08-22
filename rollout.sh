#!/usr/bin/env bash
set +e

# PEM vars
deployment_key="deployment"
deployment_path=ssh/${deployment_key}
deployment_pem="${deployment_path}.pem"

jumpbox_key="jumpbox"
jumpbox_path=ssh/${jumpbox_key}
jumpbox_pem="${jumpbox_path}.pem"


# TF opsdir
cd $(dirname $0)/src

# Start her up
[ ! -d '.terraform' ] && terraform init


# Generate keys for the rollout (deployment.pem/pub) and the jumpbox rollout (jumpbox.pub/.pem) in the sub directory ssh
mkdir -p ssh

[ ! -f "${deployment_pem}" ] && {
  ssh-keygen -t rsa -C "${deployment_key}" -P '' -f ${deployment_path} -b 1024
  mv ${deployment_path} ${deployment_pem}
  chmod 400 ${deployment_pem}
}

[ ! -f "${jumpbox_pem}" ] && {
  ssh-keygen -t rsa -C "${jumpbox_key}" -P '' -f ${jumpbox_path} -b 1024
  mv ${jumpbox_path} ${jumpbox_pem}
  chmod 400 ${jumpbox_pem}
}


# Deploy the nat instance, jumpbox instance with terraform; moreover trigger the script to create a jumpbox director
terraform plan      2>&1 >| ../logs/plan.log
terraform apply     2>&1 >| ../logs/apply.log


# But who was phone?
terraform output    2>&1 >| ../logs/out.log
