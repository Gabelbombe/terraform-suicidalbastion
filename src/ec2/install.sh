#!/usr/bin/env bash

echo -e "
## Environment file
internal_cidr=$1
internal_gw=$2
internal_ip=$3
access_key_id=$4
secret_access_key=$5
subnet_id=$6
aws_az=$7
aws_region=$8
private_key_file=$9
" > ~/.env

echo " --Update system-- "
sudo apt -y update
sudo apt -y upgrade

# Install prerequisites
sudo apt -y install                                                   \
  git gcc make ruby zlibc zlib1g-dev ruby-bundler ruby-dev            \
  build-essential patch libssl-dev bison openssl libreadline6         \
  libreadline6-dev curl git-core libssl-dev libyaml-dev libxml2-dev   \
  autoconf libc6-dev ncurses-dev automake libtool

# Install uaac
sudo gem install cf-uaac
