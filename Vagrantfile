Vagrant.configure("2") do |config|
  config.vm.provision "shell", path: "webserver.sh"
  config.vm.define "sosmed" do |sosmed|
    sosmed.vm.box = "ubuntu/xenial64"
    sosmed.vm.network "private_network",ip: "192.168.56.55"
      sosmed.vm.provider "virtualbox" do |v|
        v.memory = 1024
        v.cpus = 1
     end
  end
end
