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
# |_______| |_______|    Tested on UbuntuStudio 24.04
#

# INITIAL UPGRADE
sudo apt update && sudo apt upgrade -y

# Add i386 support
sudo dpkg --add-architecture i386

# INSTALL SOFTWARE FROM REPOSITORY
#--from ubuntu repo
sudo apt install -y docker-compose-v2 docker.io dolphin-plugins filezilla git gufw htop keepassxc nfoview poedit ufw unrar virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso winetricks

# ADDITIONAL REPOSITORIES
#---wine
sudo dpkg --add-architecture i386
sudo mkdir -pm755 /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/noble/winehq-noble.sources
sudo apt update
sudo apt install --install-recommends winehq-staging
sudo apt install winetricks

# INSTALL NON-FREE DPKG SOFTWARE
#getting debs
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
wget --content-disposition https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2024.04.17_amd64.deb
wget --content-disposition https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64
wget https://github.com/Ulauncher/Ulauncher/releases/download/5.15.7/ulauncher_5.15.7_all.deb
#installing...
sudo apt install ./code*.deb
sudo apt install ./google-chrome*.deb
sudo apt install ./dropbox*.deb
sudo apt install ./ulauncher*.deb
#cleaning...
rm -r *.deb

# YABRIDGE
wget -O yabridge.tar.gz https://github.com/robbert-vdh/yabridge/releases/download/5.1.0/yabridge-5.1.0.tar.gz
mkdir -p ~/.local/share
tar -C ~/.local/share -xavf yabridge.tar.gz
rm yabridge.tar.gz

# SPANISH LANGUAGE
sudo apt install -y language-pack-gnome-es language-pack-kde-es aspell-es $(check-language-support)

# PERMISSIONS
# Add me to any groups I might need to be a part of:
sudo adduser $USER docker
sudo adduser $USER vboxusers

#FLATPAKS
sudo apt install flatpak plasma-discover-backend-flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# FINAL STEPS
# Install TLP for laptops
#sudo apt install -y tlp tlp-rdw
#sudo tlp start
# Remove unused software
sudo apt autoremove -y
# Gotta reboot now:
echo $'\n'$"*** Reboot now. ***"
