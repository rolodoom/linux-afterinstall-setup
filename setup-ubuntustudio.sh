#!/bin/bash
#  _______   _______
# |  _____| |  ___  |
# | |       | |   | |    Rolando Ramos Torres (@rolodoom)
# | |       | |___| |    http://rolandoramostorres.com
# |_|       |_______|
#  _         _______
# | |       |  ___  |
# | |       | |   | |    After install script
# | |_____  | |___| |    for my Home Studio Box
# |_______| |_______|    Tested on UbuntuStudio 21.04
#

# INITIAL UPGRADE
sudo apt update && sudo apt upgrade -y

# Add i386 support
sudo dpkg --add-architecture i386

# ADDITIONAL REPOSITORIES
#---wine
wget -nc https://dl.winehq.org/wine-builds/winehq.key
sudo apt-key add winehq.key
sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ hirsute main'
rm -rf winehq.key
#---libreoffice
sudo add-apt-repository ppa:libreoffice/ppa
#update && upgrade
sudo apt update && sudo apt full-upgrade -y

# LAMP SERVER
# tasksel
sudo apt install -y tasksel
sudo tasksel install lamp-server
# modrewrte
sudo a2enmod rewrite
# restart apache
sudo systemctl restart apache2
# phpmyadmin
sudo apt install phpmyadmin
# Uncomment to secure mysql installation. Mut be done after installing phpmyadmin or there will be problems
# sudo mysql_secure_installation
# Generate PDF thumbnails uncomment PDF Policy here:
sudo apt install php-imagick
# sudo nano /etc/ImageMagick-6/policy.xml
sudo systemctl restart apache2

# INSTALL SOFTWARE FROM REPOSITORY
#---wine-hq
sudo apt install --install-recommends winehq-staging
#--from ubuntu repo
sudo apt install -y latte-dock git neofetch htop flatpak dolphin-plugins winetricks winbind neofetch filezilla poedit libreoffice-style-breeze typecatcher posterazor keepassxc gufw handbrake simplescreenrecorder polyphone npm virtualbox virtualbox-guest-additions-iso virtualbox-ext-pack

# INSTALL NON-FREE DPKG SOFTWARE
#getting debs
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
wget --content-disposition https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2020.03.04_amd64.deb
# visual studio code
wget --content-disposition https://go.microsoft.com/fwlink/?LinkID=760868
wget deb https://github.com/Ulauncher/Ulauncher/releases/download/5.10.0/ulauncher_5.10.0_all.deb
wget https://github.com/TheAssassin/AppImageLauncher/releases/download/v2.2.0/appimagelauncher_2.2.0-travis995.0f91801.bionic_amd64.deb
wget https://github.com/osxmidi/LinVst/releases/download/4.1/LinVst-64bit-32bit_4.1.0.deb
#installing...
sudo apt install ./code*.deb
sudo apt install ./google-chrome*.deb
sudo apt install ./dropbox*.deb
sudo apt install ./ulauncher*.deb
sudo apt install ./appimagelauncher*.deb
sudo apt install ./LinVst*.deb

# SPANISH LANGUAGE
sudo apt install -y language-pack-gnome-es language-pack-kde-es aspell-es $(check-language-support)

# PERMISSIONS
# Add me to any groups I might need to be a part of:
sudo adduser $USER www-data
sudo adduser $USER vboxusers
# -- default ubuntu groups --
# adm cdrom sudo audio dip www-data plugdev lpadmin lxd sambashare vboxusers
# Permissions on public_html folder on /home directory, where I usually
sudo chown -R www-data:www-data /var/www/
sudo chmod -R g+rwX /var/www/
sudo chown -R www-data:www-data /home/public_html/
sudo chmod -R g+rwX /home/public_html/

#FLATPAKS
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub org.gtk.Gtk3theme.Materia-dark

# FINAL STEPS
# Install TLP for laptops
#sudo apt install -y tlp tlp-rdw
#sudo tlp start
# Remove unused software
sudo apt autoremove -y
# Disable Apache and Mysql services at boot
sudo systemctl disable apache2
sudo systemctl disable mysql.service
# Some cleanning
# Delete DPK installers
rm -r *.deb
# Gotta reboot now:
echo $'\n'$"*** Reboot now. ***"



