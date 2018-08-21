#!/usr/bin/env bash

set +e -x

deployment_key="deployment"
deployment_path=ssh/${deployment_key}
deployment_pem="${deployment_path}.pem"

jumpbox_key="jumpbox"
jumpbox_path=ssh/${jumpbox_key}
jumpbox_pem="${jumpbox_path}.pem"

cd $(dirname $0)/src

# Generate keys for the rollout (deployment.pem/pub) and the jumpbox rollout (jumpbox.pub/.pem) in the sub directory ssh
mkdir -p ssh
[ ! -f ${deployment_pem}  ] && {
  ssh-keygen -t rsa -C "${deployment_key}" -P '' -f ${deployment_path} -b 4096
  mv ${deployment_path} ${deployment_pem}
  chmod 400 ${deployment_pem}
}

[ ! -f ${jumpbox_pem}  ] && {
  ssh-keygen -t rsa -C "${jumpbox_key}" -P '' -f ${jumpbox_path} -b 4096
  mv ${jumpbox_path} ${jumpbox_pem}
  chmod 400 ${jumpbox_pem}
}

# Start her up
[ ! -d '.terraform' ] && terraform init

# Deploy the nat instance, jumpbox instance with terraform; moreover trigger the script to create a jumpbox director
terraform plan --out=plan
terraform apply plan
