#!/bin/bash
set -e

echo "Initiating create of new instance running Wordpress..."

ansible-playbook \
  --private-key /Users/wchrisjohnson/.vagrant.d/insecure_private_key \
  -u vagrant \
  -i ansible/inventory/dev\
  ansible/wordpress.yml

echo "Done."
