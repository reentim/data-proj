# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "hashicorp-vagrant/ubuntu-16.04"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.33.13"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "shell", inline: <<-SHELL
    # install postgres and a recent ruby
    if ! (which psql > /dev/null); then
      apt-add-repository ppa:brightbox/ruby-ng
      apt-get update
      apt-get install -y postgresql libpq-dev ruby2.5 ruby2.5-dev
    fi

    # create a postgres role
    if ! (#{%q[su - -c 'psql -c "\du"' postgres | grep vagrant > /dev/null]}); then
      su - -c 'createuser vagrant -sRde' postgres
    fi

    # install bundler gem, which will install and manage gems for us
    if ! (which bundle > /dev/null); then
      gem install bundler
    fi

    if ! (cd /vagrant && bundle check > /dev/null); then
      su - -c 'cd /vagrant && bundle install' vagrant
    fi

    # vim configuration
    if ! (stat /home/vagrant/.vim/plugin/sensible.vim > /dev/null 2>&1); then
      mkdir -p /home/vagrant/.vim/plugin
      curl --silent https://raw.githubusercontent.com/tpope/vim-sensible/master/plugin/sensible.vim -o /home/vagrant/.vim/plugin/sensible.vim
      chown -R vagrant /home/vagrant/.vim
    fi

    if ! (grep expandtab /home/vagrant/.vimrc > /dev/null 2>&1); then
      echo "set expandtab tabstop=2 softtabstop=2 shiftwidth=2" >> /home/vagrant/.vimrc
      chown -R vagrant /home/vagrant/.vimrc
    fi
  SHELL
end
