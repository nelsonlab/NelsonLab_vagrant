# vagrant

This will set up a fully functional development environment. No more wondering if your machine is configured correctly, and no more wasting time setting up dependencies. 
Spin up a NelsonLab virtual machine and start developing.

##Pre-reqs

Install Vagrant from https://www.vagrantup.com/downloads.html

Make sure you have VirtualBox AND the VirtualBox Extension Pack installed
https://www.virtualbox.org/wiki/Downloads


##Initializing

Make a directory for vagrant on your machine
```
mkdir vagrant/
cd vagrant
```


Git clone this repo to your machine into that directory.
```
git clone https://github.com/solgenomics/SGN_vagrant.git
```


##Using vagrant

Go to the NelsonLab_vagrant directory that you git cloned.
```
cd vagrant/NelsonLab_vagrant/
```

Tell vagrant to configure the VM
```
vagrant up
```

The VM will show up as a regular VM in Virtualbox from this point on. You can start/stop the VM through virtual box.
Vagrant has its own start/stop/reload commands if you don't want to use virtualbox: https://www.vagrantup.com/docs/cli/


To remove any trace of the VM
```
vagrant destroy
```

##Info

User Info:
```
username: vagrant
password: vagrant
```

Localhost apache server is running, so project is running by default 
```
On VM: localhost:80
On Host: localhost:8080
```

The terminal is Byobu.

Text editors on the machine are:
```
subl
emacs
gedit
```
I prefer to use the sublime text editor.

##Known Issues:

The GUI is unresponsive the first time you setup the VM. You have to reset the VM. In VirtualBox, go to Machine->Reset.


