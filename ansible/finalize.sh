#!/bin/bash
set -e

cd /home/vagrant/devstack/

echo "===== Set up DNS, open ports ..."

source openrc

# set up DNS on subnet
neutron subnet-update private-subnet --dns-nameservers list=true 8.8.8.8

echo "----- DNS setup complete."

echo "===== Security group changes ..."

# enable ping, ssh and http access
nova secgroup-add-rule default icmp -1 -1 0.0.0.0/0
nova secgroup-add-rule default tcp 22 22 0.0.0.0/0
nova secgroup-add-rule default tcp 80 80 0.0.0.0/0

echo "----- Security group changes complete."
