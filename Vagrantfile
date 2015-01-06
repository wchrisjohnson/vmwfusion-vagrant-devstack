# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  # config.vm.box_url = "http://domain.com/path/to/above.box"
  # config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.box = "puphpet/ubuntu1404-x64"
  config.vm.hostname = "trusty64"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network "forwarded_port", guest: 80, host: 8888

  # OpenStack ports
  config.vm.network "forwarded_port", guest: 3333, host: 3333
  config.vm.network "forwarded_port", guest: 5000, host: 5000
  config.vm.network "forwarded_port", guest: 8000, host: 8000
  config.vm.network "forwarded_port", guest: 8004, host: 8004
  config.vm.network "forwarded_port", guest: 8080, host: 8080
  config.vm.network "forwarded_port", guest: 8773, host: 8773
  config.vm.network "forwarded_port", guest: 8774, host: 8774
  config.vm.network "forwarded_port", guest: 8776, host: 8776
  config.vm.network "forwarded_port", guest: 9292, host: 9292
  config.vm.network "forwarded_port", guest: 9696, host: 9696
  config.vm.network "forwarded_port", guest: 35357, host: 35357

  # eth0 - vmnet0
  # This nic is owned/controlled by vagrant.

  # eth1 - vmnet8
  # This is equivalent to "Private to my mac"
  # The virtual machine is connected to your Mac using
  # a private virtual network. The private network is not
  # normally accessible from the physical networks on
  # the Mac.
  # Multiple virtual machines can be connected to the
  # same private network.
  config.vm.network "private_network", ip: "172.16.40.128" #, auto_config: true

  # A "public_network" config will put a nic on my local
  # network, 192.168.123.x, which I DO NOT want to do.
  # config.vm.network "public_network"

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  config.ssh.forward_agent = true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder "/Users/wchrisjohnson/code/vagrant/vagrant_data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  config.vm.provider "vmware_fusion" do |v|
    # Boot option: true = GUI, false = headless
    v.gui = true
    v.vmx["memsize"] = "8192"
    v.vmx["numvcpus"] = "2"
    v.vmx["vhv.enable"] = "TRUE"
  end

  # Create devstack local.conf file and push it to vm
  # config.vm.provision :ansible do |ansible|
  #   ansible.verbose = true
  #   ansible.playbook = "ansible/devstack_config.yml"
  #   ansible.limit = 'all'
  # end

  # do the provision via shell vs ansible so we
  # can watch the progress.
  # OLD WAY
  # config.vm.provision :shell, :path => "ansible/bootstrap.sh", :privileged => false
  # NEW WAY
  # config.vm.provision :ansible do |ansible|
  #   ansible.verbose = true
  #   ansible.playbook = "ansible/bootstrap.yml"
  #   ansible.limit = 'all'
  # end

  # Open up eth0 for outbound acces from guest VMs
  # config.vm.provision :ansible do |ansible|
  #   ansible.verbose = true
  #   ansible.playbook = "ansible/enable_outbound_guest_vms.yml"
  #   ansible.limit = 'all'
  # end


  # Create a keypair, add it to devstack
  # config.vm.provision :ansible do |ansible|
  #   ansible.verbose = true
  #   ansible.playbook = "ansible/keypair.yml"
  #   ansible.limit = 'all'
  # end


  # Setup DNS and open ports
  # OLD WAY
  # config.vm.provision :shell, :path => "ansible/finalize.sh", :privileged => false
  # NEW WAY
  # config.vm.provision :ansible do |ansible|
  #   ansible.verbose = true
  #   ansible.playbook = "ansible/finalize.yml"
  #   ansible.limit = 'all'
  # end


  # Install tinyproxy, forward to guest vm
  # config.vm.provision :ansible do |ansible|
  #   ansible.verbose = true
  #   ansible.playbook = "ansible/tinyproxy.yml"
  #   ansible.limit = 'all'
  # end


  # upload os images to glance
  # config.vm.provision :ansible do |ansible|
  #   ansible.verbose = true
  #   ansible.playbook = "ansible/upload_images.yml"
  #   ansible.limit = 'all'
  # end

end
