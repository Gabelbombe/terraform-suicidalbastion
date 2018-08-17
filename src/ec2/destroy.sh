#!/usr/bin/env bash

set +e

internal_cidr=$1
internal_gw=$2
internal_ip=$3
access_key_id=$4
secret_access_key=$5
subnet_id=$6
aws_az=$7
aws_region=$8
private_key_file=$9

## Shutdown and terminate instance in 15 minutes
echo "sudo halt" |at now + 15 minutes
