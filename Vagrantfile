# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  config.vm.provider :vmware_fusion do |v, override|
    override.vm.box = "precise64_vmware"
    config.vm.box_url = "http://files.vagrantup.com/precise64_vmware.box"
  end

  config.vm.provision :shell, path: 'scripts/bootstrap_dev.sh', privileged: false
  config.vm.network :forwarded_port, guest: 8000, host: 8000
  config.vm.network :forwarded_port, guest: 5432, host: 5432
end
