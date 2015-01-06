#!/bin/bash
set -e

echo "DNS & Ports"

ansible-playbook \
  --private-key /Users/wchrisjohnson/.vagrant.d/insecure_private_key \
  -u vagrant \
  -i ansible/inventory/dev\
  ansible/finalize.yml

echo "Done"
