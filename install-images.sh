#!/bin/bash
set -e

echo "Installing images"

ansible-playbook \
  --private-key /Users/wchrisjohnson/.vagrant.d/insecure_private_key \
  -u vagrant \
  -i ansible/inventory/dev\
  ansible/install-images.yml

echo "Done"
