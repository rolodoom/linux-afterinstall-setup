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
# |_______| |_______|    Tested on Kubuntu 20.04 LTS
#

# REMOVE SNAP
sudo apt purge snapd -y

# INITIAL UPGRADE
sudo apt update && sudo apt upgrade -y

# Add i386 support
sudo dpkg --add-architecture i386

# ADDITIONAL REPOSITORIES
sudo apt install -y curl
# getting repos
curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash -
#---ubuntustudio backports
sudo add-apt-repository ppa:ubuntustudio-ppa/backports
sudo add-apt-repository ppa:ubuntustudio-ppa/ardour-backports
#---wine
wget -nc https://dl.winehq.org/wine-builds/winehq.key
sudo apt-key add winehq.key
sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main'
rm -rf winehq.key
#---inkscape
sudo add-apt-repository ppa:inkscape.dev/stable
#---libreoffice
sudo add-apt-repository ppa:libreoffice/ppa
#---kdenlive
sudo add-apt-repository ppa:kdenlive/kdenlive-stable
# upgrade after repos
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
sudo apt install -y phpmyadmin
# Uncomment to secure mysql installation. Mut be done after installing phpmyadmin or there will be problems
# sudo mysql_secure_installation
# Generate PDF thumbnails uncomment PDF Policy here:
sudo apt install php-imagick
# sudo nano /etc/ImageMagick-6/policy.xml 
sudo systemctl restart apache2

# INSTALL SOFTWARE FROM REPOSITORY
#---standar repo install
sudo apt install -y flatpak htop dolphin-plugins winetricks neofetch filezilla poedit pdfarranger libreoffice libreoffice-style-breeze gimp inkscape scribus typecatcher posterazor git ardour audacity soundconverter keepassxc gufw kid3 k3b ktorrent kdenlive handbrake simplescreenrecorder nodejs linux-lowlatency studio-controls ubuntustudio-audio-plugins ubuntustudio-lowlatency-settings ubuntustudio-performance-tweaks carla carla-lv2 carla-vst zam-plugins dragonfly-reverb virtualbox virtualbox-guest-additions-iso virtualbox-ext-pack
#---wine
sudo apt install --install-recommends winehq-staging

# INSTALL NON-FREE DPKG SOFTWARE
#getting debs
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
wget -O dropbox_amd64.deb --content-disposition https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2020.03.04_amd64.deb
wget -O ulauncher_all.deb https://github.com/Ulauncher/Ulauncher/releases/download/5.10.0/ulauncher_5.10.0_all.deb
wget -O appimagelauncher_amd64.deb https://github.com/TheAssassin/AppImageLauncher/releases/download/v2.2.0/appimagelauncher_2.2.0-travis995.0f91801.bionic_amd64.deb
wget -O LinVst_amd64.deb https://github.com/osxmidi/LinVst/releases/download/4.1/LinVst-64bit-32bit_4.1.0.deb
wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
wget -O code_amd64.deb 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64'
wget -O edge_beta_amd64.deb 'https://go.microsoft.com/fwlink/?linkid=2149139'
#installing...
sudo apt install ./google-chrome-stable_current_amd64.deb ./dropbox_amd64.deb ./ulauncher_all.deb ./appimagelauncher_amd64.deb ./LinVst_amd64.deb ./teamviewer_amd64.deb ./code_amd64.deb ./edge_beta_amd64.deb

# SPANISH LANGUAGE
sudo apt install -y language-pack-gnome-es language-pack-kde-es aspell-es $(check-language-support)

# MY SHELL SCRIPTS
git clone https://github.com/rolodoom/shell-scripts.git
chmod +x shell-scripts/install.sh
./shell-scripts/install.sh

# ENABLE FIREWALL
sudo ufw enable

# PERMISSIONS
# Add me to any groups I might need to be a part of:
sudo adduser $USER www-data
sudo adduser $USER vboxusers
# -- default ubuntu groups --
# adm cdrom sudo audio dip www-data plugdev lpadmin lxd sambashare vboxusers
# Permissions on public_html folder on $HOME directory, where I usually
sudo chown -R www-data:www-data /var/www/
sudo chmod -R g+rwX /var/www/
sudo chown -R www-data:www-data ~/public_html/
sudo chmod -R g+rwX ~/public_html/

# INSTALL FROM FLATPAK
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub org.musescore.MuseScore io.github.wereturtle.ghostwriter

# FINAL STEPS
# Remove unused software
sudo apt autoremove -y
# Final APT update
sudo apt update && sudo apt upgrade -y
# Gotta reboot now:
echo $'\n'$"*** Reboot now. ***"
