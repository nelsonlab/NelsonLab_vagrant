	
	#Update Aptitude
    sudo apt-get update && sudo apt-get upgrade
	sudo apt-get install gcc build-essential module-assistant
	
	#Install Emacs and gedit
	#sudo apt-get install emacs -y 
	#sudo apt-get install gedit
	
	#Install Iceweasel
	sudo apt-get install iceweasel -y
	
	#Install libreoffice
	#sudo apt-get install libreoffice -y
	
	#Install git 
	sudo apt-get install git -y
	
	#Install Apache
	sudo apt-get install apache2 -y
	
	#Install postgres 9.4
	sudo apt-get install mysql -y
	
	#Install wget
	sudo apt-get install wget -y 
	
	#Install barebones gnome GUI
	sudo apt-get install gnome-shell -y
	sudo apt-get install gnome-terminal -y
	sudo apt-get install x-terminal-emulator -y
	
	#Install full gnome (takes forever)
	# sudo apt-get install ubuntu-gnome-desktop -y
	
	#Install linux headers for good measure
	sudo apt-get install linux-headers-$(uname -r) -y
	
	#Permit any user to start the GUI
	sudo sed -i s/allowed_users=console/allowed_users=anybody/ /etc/X11/Xwrapper.config
	
	#Set root user password to vagrant 
	yes vagrant | sudo passwd root
	
	#Set Superuser: vagrant user already NOPASSWD superuser
	
	#Install python mysql dependencies
	sudo apt-get install -y python-pip apache2 libapache2-mod-wsgi
	#sudo apt-get install -y mysql-server mysql-client
	#sudo apt-get install libmysqlclient-dev -y 
	#sudo apt-get install python-mysqldb -y 
	#sudo apt-get install python-dev -y 
	#sudo apt-get install -y libtiff5-dev libjpeg8-dev zlib1g-dev libfreetype6-dev liblcms2-dev libwebp-dev tcl8.6-dev tk8.6-dev python-tk
	sudo pip install virtualenv
	wget -O /home/vagrant/config/ez_setup.py "https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py"
	python /home/vagrant/config/ez_setup.py 
	easy_install pip 

	mkdir /srv/nelsonlab
	cd /srv/nelsonlab
	git clone https://github.com/nelsonlab/django_NelsonDB.git
	cp /home/vagrant/config/settings.py /srv/nelsonlab/django_NelsonDB/webapp/ 
	virtualenv venv 
	source venv/bin/activate
	pip install -U setuptools pip
	pip install django mysql-python
	pip install Pillow
	
	#sudo service mysql start
	
	#Make and populate directory
	#sudo mkdir /data 
	#sudo mkdir /data/srv
	#sudo mkdir /data/srv/nelsonlab
	#cd /data/srv/nelsonlab
	#git clone https://github.com/nelsonlab/django_NelsonDB.git
	#git checkout NelsonLab
	#sudo mv /data/srv/nelsonlab/django_NelsonDB/ /data/srv/nelsonlab/webapp/ 
	
	#Add settings.py, copied from shared config directory 
	#sudo cp /home/vagrant/config/settings.py /data/srv/nelsonlab/webapp/webapp/ 
	#sudo chown -R vagrant:vagrant /home/vagrant/cxgn/
	
	#cd /data/srv/nelsonlab/webapp 
	#sudo python manage.py makemigrations
	#sudo python manage.py migrate
	
	#Start GNOME3 GUI
	sudo gdm start&
	#startx&
	