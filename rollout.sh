#!/usr/bin/env bash

set +e

tf-deployment_key="tf-deployment"
tf-deployment_path=ssh/${tf-deployment_key}
tf-deployment_pem="${tf-deployment_path}.pem"

ehime_key="ehime"
ehime_path=ssh/${ehime_key}
ehime_pem="${ehime_path}.pem"

cd $(dirname $0)/src

# Generate keys for the rollout (tf-deployment.pem/pub) and the ehime rollout (ehime.pub/.pem) in the sub directory ssh
mkdir -p ssh
[ ! -f ${tf-deployment_pem}  ] && {
  ssh-keygen -t rsa -C "${tf-deployment_key}" -P '' -f ${tf-deployment_path} -b 4096
  mv ${tf-deployment_path} ${tf-deployment_pem}
  chmod 400 ${tf-deployment_pem}
}

[ ! -f ${ehime_pem}  ] && {
  ssh-keygen -t rsa -C "${ehime_key}" -P '' -f ${ehime_path} -b 4096
  mv ${ehime_path} ${ehime_pem}
  chmod 400 ${ehime_pem}
}

# Deploy the nat instance, jumpbox instance with terraform; moreover trigger the script to create a ehime director
terraform plan --out=plan
terraform apply plan
