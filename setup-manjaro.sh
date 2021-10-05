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


# TLP - uncomment to enable
#sudo systemctl enable tlp --now
# SSH - uncomment to enable
#sudo systemctl enable sshd --now

# Full distro Upgrade
sudo pacman -Syu

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
sudo pacman -S audacity soundconverter kdenlive musescore vlc dragonfly-reverb lsp-plugins calf caps carla dpf-plugins tap-plugins zam-plugins eq10q surge ebumeter x42-plugins

# Add Other Software
sudo pacman -S gimp inkscape libreoffice-fresh keepassxc aspell-es code gufw libmythes mythes-es papirus-icon-theme papirus-maia-icon-theme dolphin-plugins

#AUR
sudo pacman -S yay
sudo pacman -S --needed base-devel
yay -S dropbox
yay -S dropbox-plasma-dark-icons-git
yay -S code-marketplace
