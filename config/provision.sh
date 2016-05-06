
	#Change hostname to nelsonlab
	old=$(hostname)
	new="nelsonlab"
	for file in \
	   /etc/exim4/update-exim4.conf.conf \
	   /etc/printcap \
	   /etc/hostname \
	   /etc/hosts \
	   /etc/ssh/ssh_host_rsa_key.pub \
	   /etc/ssh/ssh_host_dsa_key.pub \
	   /etc/motd \
	   /etc/ssmtp/ssmtp.conf
	do
	   sudo [ -f $file ] && sudo sed -i.old -e "s:$old:$new:g" $file
	done
	sudo hostname nelsonlab
	
	#Update Aptitude
    sudo apt-get update && sudo apt-get upgrade
	sudo apt-get install -y gcc build-essential module-assistant
	sudo apt-get install virtualbox-guest-additions-iso -y 
	
	#Install Emacs and gedit
	sudo apt-get install emacs -y 
	sudo apt-get install gedit -y
	
	#Install Sublime text editor
	#sudo add-apt-repository ppa:webupd8team/sublime-text-3
	#sudo apt-get update
	#sudo apt-get install sublime-text-installer
	
	#Install Iceweasel
	sudo apt-get install iceweasel -y
	
	#Install libreoffice
	sudo apt-get install libreoffice -y
	
	#Install git 
	sudo apt-get install git -y
	
	#Install Apache
	sudo apt-get install apache2 -y
	
	#Install wget
	sudo apt-get install wget -y 
	
	#Install barebones gnome GUI
	sudo apt-get install gnome-core -y
	sudo apt-get install gnome-shell -y
	sudo apt-get install gnome-terminal -y
	sudo apt-get install x-terminal-emulator -y
	sudo apt-get install -y gnome-screensaver gnome-tweak-tool
	sudo add-apt-repository ppa:webupd8team/gnome3
	sudo apt-get update
	sudo apt-get install gnome-shell-extensions -y
	
	#Install full gnome (takes forever)
	# sudo apt-get install ubuntu-gnome-desktop -y
	
	#Install file manager
	sudo apt-get install nautilus -y
	
	#Install linux headers for good measure
	sudo apt-get install linux-headers-$(uname -r) -y
	
	#Permit any user to start the GUI
	sudo sed -i s/allowed_users=console/allowed_users=anybody/ /etc/X11/Xwrapper.config
	
	#Set root user password to vagrant 
	yes vagrant | sudo passwd root
	
	#Set Superuser: vagrant user already NOPASSWD superuser
	
	#Install python deps dependencies
	sudo apt-get install -y python-pip libapache2-mod-wsgi
	
	#Install pip
	mkdir /home/vagrant/Downloads
	cd /home/vagrant/Downloads
	wget "https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py"
	python ez_setup.py 
	easy_install pip 
	
	#Install mysql with no password for root user  
	DEBIAN_FRONTEND=noninteractive sudo -E apt-get install -y mysql-server-5.5
	#Install mysql python env deps 
	sudo apt-get install -y mysql-client libmysqlclient-dev python-mysqldb python-dev
	sudo apt-get install -y libtiff5-dev libjpeg8-dev zlib1g-dev libfreetype6-dev liblcms2-dev libwebp-dev tcl8.6-dev tk8.6-dev python-tk

	#Make project directory, git clone project, copy settings.py for webapp, and change ownership of it all to vagrant user 
	sudo pip install virtualenv
	mkdir /srv/nelsonlab
	cd /srv/nelsonlab
	git clone https://github.com/nelsonlab/django_NelsonDB.git
	cp /home/vagrant/config/settings.py /srv/nelsonlab/django_NelsonDB/webapp/ 
	sudo chown vagrant:vagrant -R /srv/nelsonlab/
	#Make virtualenv and enter venv and install python project app deps 
	virtualenv venv 
	source venv/bin/activate
	pip install django mysql-python Pillow
	
	#Start mysql, create database, and load initial sql dump
	mysql -u root -e "create database nelsondb_test CHARACTER SET utf8";
	cd /srv/nelsonlab/django_NelsonDB
	python manage.py makemigrations
	python manage.py migrate 
	mysql -u root -h localhost nelsondb_test < /srv/nelsonlab/django_NelsonDB/base_db_info.sql
	
	#Enable localhost live apache server
	sudo a2dissite 000-default.conf
	sudo cp /home/vagrant/config/nelsonlab.conf /etc/apache2/sites-available/
	sudo cp /home/vagrant/config/wsgi.py /srv/nelsonlab/django_NelsonDB/webapp/
	sudo a2ensite nelsonlab.conf
	sudo service apache2 reload
	
	#Install Atom text editor and cleanup
	sudo apt-get install xdg-utils -y
	wget https://github.com/atom/atom/releases/download/v1.6.0/atom-amd64.deb
	sudo dpkg --install atom-amd64.deb
	sudo apt-get -f install -y
	rm atom-amd64.deb
	
	#Install Chrome and cleanup
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo dpkg --install google-chrome-stable_current_amd64.deb
	sudo apt-get -f install -y
	rm google-chrome-stable_current_amd64.deb
	
	#Start GNOME3 GUI
	sudo gdm start&
	#startx&
	