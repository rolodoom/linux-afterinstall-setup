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
# |_______| |_______|    Tested on Manjaro
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
sudo pacman -S bash-completion yay

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

#AUR
yay -S dropbox
yay -S dropbox-plasma-dark-icons-git
yay -S code-marketplace
yay -S color-picker-git
