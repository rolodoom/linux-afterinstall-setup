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
# |_______| |_______|    Tested on Manjaro 21.1.4 Pahvo
#


# BACKUPS - Install and don't forget to backup
sudo pacman -S timeshift

# TLP - uncomment to enable
#sudo systemctl enable tlp --now
# SSH - uncomment to enable
#sudo systemctl enable sshd --now

# Full distro Upgrade
sudo pacman -Syu

# Add System software
sudo pacman -S bash-completion

# Configure Audio Workstation
sudo pacman -S jack2 a2jmidid
sudo pacman -S cadence
# Create audio group if it doesn't exists
sudo groupadd audio
# Add user to audio group
sudo usermod -aG audio $USER
# Add realtime privileges to audio group at limits.conf
# URL: https://jackaudio.org/faq/linux_rt_config.html
#---edit file
# sudo nano /etc/security/limits.conf
#---add this lines before 'End of file' comment
# audio group
#@audio           -       rtprio          95
#@audio           -       memlock         unlimited

# Add Audio / Video Workstation Software
sudo pacman -S ardour audacity soundconverter kdenlive musescore vlc dragonfly-reverb lsp-plugins calf caps carla dpf-plugins tap-plugins zam-plugins eq10q  surge ebumeter x42-plugins

# Add Other Software
sudo pacman -S gimp inkscape libreoffice-fresh keepassxc aspell-es ulauncher code gufw libmythes mythes-es papirus-icon-theme papirus-maia-icon-theme neofetch code

# AUR
# install dependencies for compiling AUR packages
sudo pacman -S yay base-devel
# install dropbox
yay -S dropbox
# install marketplace for codeOSS
yay -S code-marketplace


# VIRTUALBOX
#Finde the kernel version
str=$(uname -r)
readarray -d . -t splitNoIFS<<< "$str"
KERNEL="linux${splitNoIFS[0]}${splitNoIFS[1]}"
# install Virtualbox and modules
sudo pacman -Syu virtualbox ${KERNEL}-virtualbox-host-modules
# reload
sudo modprobe vboxdrv
sudo vboxreload
# Install  Oracle Extenssion Pack
pamac build virtualbox-ext-oracle
