#!/bin/bash
set -e

echo "Running ansible-playbook to provision devstack..."

ansible-playbook \
  --private-key /Users/wchrisjohnson/.vagrant.d/insecure_private_key \
  -u vagrant \
  -i ansible/inventory/dev\
  ansible/provision.yml

echo "Provision Complete."
