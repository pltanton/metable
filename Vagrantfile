# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.vm.box = 'ogarcia/archlinux-x64'
  config.vm.network 'forwarded_port', guest: 80, host: 8080
  config.vm.host_name = 'metable'
  config.vm.provision :shell, path: 'Vagrant-setup.sh'
  config.vm.provider 'virtualbox'do |vb|
    vb.name = "metable"
  end

  config.vm.network 'forwarded_port', guest: 5432, host: 15_432
end
