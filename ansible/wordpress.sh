#!/bin/bash
set -e

cd /home/vagrant/devstack/

echo "===== Boot an Ubuntu instance, install wordpress..."

source openrc

# get list of flavors to get flavor id
# nova flavor-list

# get list of images to discover guid for 'trusty-server-cloudimg-i386-disk1'
# nova image-list

# get network list for private network id
# nova network-list

echo "Create a new floating IP"
# nova floating-ip-create

echo "Booting a new instance for wordpress"
nova boot \
  --flavor "3" \
  --image "9100c158-bf71-422c-ac58-2249466efd5d" \
  --key_name "demo" \
  --user_data /home/vagrant/wordpress_user_data.txt \
  --security_groups "default" \
  --nic "net-id=30c8a424-9648-4034-afc9-612e5dfbc493" \
  --meta "wordpress_user=demo" \
  --meta "wordpress_password=stack" \
  wordpress

echo "Assigning a floating IP address"
nova floating-ip-associate wordpress 172.24.4.3

echo "----- Setup complete."


# usage: nova boot [--flavor <flavor>] [--image <image>]
#                  [--image-with <key=value>] [--boot-volume <volume_id>]
#                  [--snapshot <snapshot_id>] [--min-count <number>]
#                  [--max-count <number>] [--meta <key=value>]
#                  [--file <dst-path=src-path>] [--key-name <key-name>]
#                  [--user-data <user-data>]
#                  [--availability-zone <availability-zone>]
#                  [--security-groups <security-groups>]
#                  [--block-device-mapping <dev-name=mapping>]
#                  [--block-device key1=value1[,key2=value2...]]
#                  [--swap <swap_size>]
#                  [--ephemeral size=<size>[,format=<format>]]
#                  [--hint <key=value>]
#                  [--nic <net-id=net-uuid,v4-fixed-ip=ip-addr,v6-fixed-ip=ip-addr,port-id=port-uuid>]
#                  [--config-drive <value>] [--poll]
#                  <name>

# FLAVORS
# 1 m1.tiny
# 2 m1.small
# 3 m1.medium
# 4 m1.large
# 5 m1.xlarge
