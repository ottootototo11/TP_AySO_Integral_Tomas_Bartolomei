Vagrant.configure("2") do |config|

  config.vm.define "ubuntu" do |ubuntu|
    ubuntu.vm.box = "ubuntu/focal64"
    ubuntu.vm.hostname = "ubuntu-testing"
    ubuntu.vm.network "private_network", ip: "192.168.56.10"

    ubuntu.vm.provider "virtualbox" do |vb|
      vb.memory = 1024
      vb.cpus   = 1

      disco1 = File.expand_path("discos/ubuntu_5G.vmdk", __dir__)
      vb.customize ["createhd", "--filename", disco1, "--size", 5120] unless File.exist?(disco1)
      vb.customize ["storageattach", :id, "--storagectl", "SCSI", "--port", 1, "--device", 0, "--type", "hdd", "--medium", disco1]

      disco2 = File.expand_path("discos/ubuntu_3G.vmdk", __dir__)
      vb.customize ["createhd", "--filename", disco2, "--size", 3072] unless File.exist?(disco2)
      vb.customize ["storageattach", :id, "--storagectl", "SCSI", "--port", 2, "--device", 0, "--type", "hdd", "--medium", disco2]

      disco3 = File.expand_path("discos/ubuntu_2G.vmdk", __dir__)
      vb.customize ["createhd", "--filename", disco3, "--size", 2048] unless File.exist?(disco3)
      vb.customize ["storageattach", :id, "--storagectl", "SCSI", "--port", 3, "--device", 0, "--type", "hdd", "--medium", disco3]

      disco4 = File.expand_path("discos/ubuntu_1G.vmdk", __dir__)
      vb.customize ["createhd", "--filename", disco4, "--size", 1024] unless File.exist?(disco4)
      vb.customize ["storageattach", :id, "--storagectl", "SCSI", "--port", 4, "--device", 0, "--type", "hdd", "--medium", disco4]
    end

    ubuntu.vm.provision "shell", path: "scripts/provision.sh"
  end

  config.vm.define "fedora" do |fedora|
    fedora.vm.box = "generic/fedora38"
    fedora.vm.hostname = "fedora-produccion"
    fedora.vm.network "private_network", ip: "192.168.56.11"

    fedora.vm.provider "virtualbox" do |vb|
      vb.memory = 1024
      vb.cpus   = 1

      disco1 = File.expand_path("discos/fedora_5G.vmdk", __dir__)
      vb.customize ["createhd", "--filename", disco1, "--size", 5120] unless File.exist?(disco1)
      vb.customize ["storageattach", :id, "--storagectl", "SCSI", "--port", 1, "--device", 0, "--type", "hdd", "--medium", disco1]

      disco2 = File.expand_path("discos/fedora_3G.vmdk", __dir__)
      vb.customize ["createhd", "--filename", disco2, "--size", 3072] unless File.exist?(disco2)
      vb.customize ["storageattach", :id, "--storagectl", "SCSI", "--port", 2, "--device", 0, "--type", "hdd", "--medium", disco2]

      disco3 = File.expand_path("discos/fedora_2G.vmdk", __dir__)
      vb.customize ["createhd", "--filename", disco3, "--size", 2048] unless File.exist?(disco3)
      vb.customize ["storageattach", :id, "--storagectl", "SCSI", "--port", 3, "--device", 0, "--type", "hdd", "--medium", disco3]

      disco4 = File.expand_path("discos/fedora_1G.vmdk", __dir__)
      vb.customize ["createhd", "--filename", disco4, "--size", 1024] unless File.exist?(disco4)
      vb.customize ["storageattach", :id, "--storagectl", "SCSI", "--port", 4, "--device", 0, "--type", "hdd", "--medium", disco4]
    end

    fedora.vm.provision "shell", path: "scripts/provision.sh"
  end

end