#!/bin/bash
set -e

echo "===== Installing git..."
sudo apt-get install git -y
echo "----- git installed."

echo "===== Cloning devstack..."
git clone -b stable/icehouse https://github.com/openstack-dev/devstack.git
echo "----- Clone of devstack complete."

echo "===== Patching stack.sh to use correct version of pip..."
cd devstack
awk '/install_pip.sh/ { print; print "sudo pip install --upgrade setuptools"; next }1' stack.sh > patched_stack.sh
chmod +x patched_stack.sh
echo "----- stack.sh patched --> patched_stack.sh"

echo "===== Writing local.conf config file..."

# export SERVICE_HOST=devstack.vagrant.dev

cat >/home/vagrant/devstack/local.conf <<SCRIPT
[[local|localrc]]

# Credentials
# -----
ADMIN_PASSWORD=stack
MYSQL_PASSWORD=stack
RABBIT_PASSWORD=stack
SERVICE_PASSWORD=stack
SERVICE_TOKEN=tokentoken


# Glance
# -----
GLANCE_BRANCH=stable/icehouse

#IMAGE_URLS+=",http://download.cirros-cloud.net/0.3.1/cirros-0.3.1-x86_64-uec.tar.gz"
# 32bit image (~660MB)
#IMAGE_URLS+=",http://fedorapeople.org/groups/heat/prebuilt-jeos-images/F19-i386-cfntools.qcow2"
# 64bit image (~640MB)
#IMAGE_URLS+=",http://fedorapeople.org/groups/heat/prebuilt-jeos-images/F19-x86_64-cfntools.qcow2"
#IMAGE_URLS+=",http://mirror.chpc.utah.edu/pub/fedora/linux/releases/20/Images/x86_64/Fedora-x86_64-20-20131211.1-sda.qcow2"


# Horizon
# -----
HORIZON_BRANCH=stable/icehouse


# Keystone
# -----
KEYSTONE_BRANCH=stable/icehouse
KEYSTONE_TOKEN_FORMAT=PKI


# Nova
# -----
NOVA_BRANCH=stable/icehouse
SCHEDULER=nova.scheduler.chance.ChanceScheduler


# Neutron
# -----
NEUTRON_BRANCH=stable/icehouse

disable_service n-net
enable_service q-svc
enable_service q-agt
enable_service q-dhcp
enable_service q-l3
enable_service q-meta
# Optional, to enable tempest configuration as part of devstack
enable_service tempest
enable_service neutron
enable_service q-fwaas
enable_service q-lbaas
enable_service q-vpn


Q_PLUGIN=ml2
ENABLE_TENANT_TUNNELS=True
TENANT_TUNNEL_RANGE=50:100
# Q_ML2_TENANT_NETWORK_TYPE=gre
Q_ML2_PLUGIN_TYPE_DRIVERS=local,flat,gre
Q_ML2_PLUGIN_MECHANISM_DRIVERS=openvswitch


# Heat
# -----
HEAT_BRANCH=stable/icehouse
ENABLED_SERVICES+=,heat,h-api,h-api-cfn,h-api-cw,h-eng
HEAT_STANDALONE=True


# Cinder
# -----
CINDER_BRANCH=stable/icehouse


# Ceilometer
# -----
#CEILOMETER_BRANCH=stable/icehouse
#ENABLED_SERVICES+=,ceilometer-acompute,ceilometer-acentral,ceilometer-collector,ceilometer-api
#ENABLED_SERVICES+=,ceilometer-alarm-notify,ceilometer-alarm-eval


# Swift
# -----
enable_service s-proxy s-object s-container s-account
SWIFT_HASH=66a3d6b56c1f479c8b4e70ab5c2000f5
SWIFT_REPLICAS=1
SWIFT_DATA_DIR=/opt/stack/data

# Logging
# -----
LOGFILE=/opt/stack/logs/stack.sh.log
LOGDAYS=2
VERBOSE=True
# OFFLINE=True
# LOG_COLOR=False
SCREEN_LOGDIR=/opt/stack/logs/screen

# HOST
# -----
# HOST_IP=172.16.231.2
# HOST_NAME=precise64
# SERVICE_HOST=172.16.231.2
# SERVICE_HOST_NAME=precise64
# MYSQL_HOST=172.16.231.2
# RABBIT_HOST=172.16.231.2
# Q_HOST=172.16.231.2

# FLAT_INTERFACE=br100
# PUBLIC_INTERFACE=eth1
# FLOATING_RANGE=172.16.231.224/27

RECLONE=yes
API_RATE_LIMIT=False

[[post-config|$NOVA_CONF]]
[DEFAULT]
scheduler_default_filters=AllHostsFilter

[[post-config|$GLANCE_API_CONF]]
[DEFAULT]
default_store=file

[[post-config|/$Q_PLUGIN_CONF_FILE]]
[DEFAULT]
tunnel_types=gre

SCRIPT

echo "----- local.conf config file complete."

echo ""
echo "===== Contents of config file..."
cat /home/vagrant/devstack/local.conf
echo "----- Content dump complete."
echo ""

echo "===== Starting stack.sh..."
./patched_stack.sh
# ./stack.sh
echo "----- stack.sh complete."

# echo "Horizon is now accessible at http://devstack.vagrant.dev"
