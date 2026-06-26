Vagrant.configure("2") do |config|
  config.vm.boot_timeout = 600

  config.vm.define "ubuntu" do |ubuntu|
    ubuntu.vm.box = "bento/ubuntu-20.04"
    ubuntu.vm.hostname = "ubuntu-testing"
    ubuntu.vm.network "private_network", ip: "192.168.56.10"
    ubuntu.vm.provider "virtualbox" do |vb|
      vb.memory = 1024
      vb.cpus   = 1
    end
    ubuntu.vm.provision "shell", path: "scripts/provision.sh"
  end

end