#!/bin/bash
set -e

echo "Adding keypair"

ansible-playbook \
  --private-key /Users/wchrisjohnson/.vagrant.d/insecure_private_key \
  -u vagrant \
  -i ansible/inventory/dev\
  ansible/keypair.yml

echo "Done"
