!/bin/bash
set -e

cd /home/vagrant/devstack/

echo "===== Add new port ..."

source openrc

# set up DNS on subnet
ovs-vsctl add-port br-ex eth1

echo "----- Port added."
