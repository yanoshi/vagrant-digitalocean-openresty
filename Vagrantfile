# -*- mode: ruby -*-
# vi: set ft=ruby :

Dotenv.load

# change default provider to digital_ocean

Vagrant.configure(2) do |config|
  # config.vm.box = "bento/ubuntu-16.04"

  # config.ssh.forward_agent = true

  machine_name  = [ "openresty" ]
  memory_size   = { "openresty"    => "512mb" } # 512MB | 1GB | 2GB | 4GB | 8GB | 16GB
  shell_path    = { "openresty"    => "script/provision_openresty.sh" }
  
  machine_name.each do |machine|
    config.vm.define "#{machine}" do |config|
      config.vm.provider :digital_ocean do |provider, override|
        override.vm.hostname          = machine
        override.vm.box               = "digital_ocean"
        override.vm.box_url           = "https://github.com/smdahlen/vagrant-digitalocean/raw/master/box/digital_ocean.box"

        override.ssh.username         = ENV['DO_SSH_USERNAME']
        override.ssh.private_key_path = ENV['DO_SSH_KEY']
        provider.token                = ENV['DO_TOKEN']
        provider.ssh_key_name         = ENV['DO_KEYNAME']
        
        provider.region               = "sgp1"
        provider.image                = "ubuntu-16-04-x64"
        provider.size                 = memory_size[machine] 
        provider.private_networking   = true
        # provider.ca_path              = "/usr/local/share/ca-bundle.crt"
        provider.setup                = true

        # rsyncを利用してフォルダ共有する
        override.vm.synced_folder "./sync_folder", "/vagrant", type: "rsync"

        # provision
        override.vm.provision :shell do |shell|
          shell.path = shell_path[machine]
          shell.args = ENV['DO_PASSPHRASE']
          shell.privileged = false
        end
      end
    end
  end
end
