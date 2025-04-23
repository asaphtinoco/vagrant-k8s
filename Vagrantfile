VAGRANTFILE_API_VERSION = "2"
require 'yaml'


Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "bento/ubuntu-22.04"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "6144"
    vb.cpus = 2
  end

  # Define static IPs for easier communication
  node_ips = {
    1 => "192.168.56.11",
    2 => "192.168.56.12",
    3 => "192.168.56.13"
  }

  (1..3).each do |i|
    config.vm.define "node#{i}" do |node|
      node.vm.hostname = "node#{i}"

      # Set a private static IP for inter-node communication
      node.vm.network "private_network", ip: node_ips[i]

      node.vm.provider "virtualbox" do |vb|
        vb.name = "node#{i}"
      end

      # Shared provisioning for all nodes
      node.vm.provision "shell", path: "provision_common.sh"

      # Extra provisioning and forwarded ports for node1
      if i == 1
        node.vm.network "forwarded_port", guest: 80, host: 8080, auto_correct: true
        node.vm.network "forwarded_port", guest: 443, host: 8443, auto_correct: true

        node.vm.provision "shell", path: "provision_rancher.sh"
      end
    end
  end
end
