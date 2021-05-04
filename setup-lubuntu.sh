#!/bin/bash
#  _______   _______
# |  _____| |  ___  |
# | |       | |   | |    Rolando Ramos Torres (@rolodoom)
# | |       | |___| |    http://rolandoramostorres.com
# |_|       |_______|
#  _         _______   
# | |       |  ___  |    After install script
# | |       | |   | |    for my wife's PC
# | |_____  | |___| |    Tested on Lubuntu 20.04 LTS
# |_______| |_______|    Based on kubuntu-setup (https://github.com/rolodoom/kubuntu-setup)
#

# INITIAL UPGRADE
sudo apt update && sudo apt upgrade -y

# Add i386 support
sudo dpkg --add-architecture i386

# ADDITIONAL REPOSITORIES
sudo apt install -y curl
# getting repos
curl -sL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
#--inkscape
sudo add-apt-repository ppa:inkscape.dev/stable
#--ubuntustudio backports
sudo add-apt-repository ppa:ubuntustudio-ppa/backports
sudo add-apt-repository ppa:ubuntustudio-ppa/ardour-backports
#---spotify
curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add - 
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
#---wine
wget -nc https://dl.winehq.org/wine-builds/winehq.key
sudo apt-key add winehq.key
sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main'
rm -rf winehq.key
# upgrade after repos
sudo apt update && sudo apt upgrade -y
sudo apt full-upgrade

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
#---wine
sudo apt install --install-recommends winehq-staging
sudo apt install -y flatpak dolphin dolphin-plugins konsole plank winetricks winbind neofetch filezilla poedit pdfarranger libreoffice libreoffice-style-breeze scribus typecatcher posterazor git ardour audacity soundkonverter keepassxc gufw kid3 ktorrent kdenlive handbrake simplescreenrecorder gwenview kde-spectacle okular kate nodejs spotify-client linux-lowlatency studio-controls ubuntustudio-audio-plugins ubuntustudio-lowlatency-settings ubuntustudio-performance-tweaks carla carla-bridge-win32 carla-bridge-win64 carla-bridge-wine32 carla-bridge-wine64 carla-data carla-lv2 carla-vst zam-plugins dragonfly-reverb virtualbox virtualbox-guest-additions-iso virtualbox-ext-pack
#---inkscape
sudo apt install inkscape

# INSTALL NON-FREE DPKG SOFTWARE
#getting debs
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
wget -O dropbox_amd64.deb --content-disposition https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2020.03.04_amd64.deb
wget -O code_amd64.deb https://go.microsoft.com/fwlink/?LinkID=760868
wget -O ulauncher_all.deb https://github.com/Ulauncher/Ulauncher/releases/download/5.10.0/ulauncher_5.10.0_all.deb
wget -O polyphone_amd64.deb https://www.polyphone-soundfonts.com/download/file/771-polyphone-ubuntu20-04-2-2-amd64-deb/latest/download
wget -O appimagelauncher_amd64.deb https://github.com/TheAssassin/AppImageLauncher/releases/download/v2.2.0/appimagelauncher_2.2.0-travis995.0f91801.bionic_amd64.deb
wget -O LinVst_amd64.deb https://github.com/osxmidi/LinVst/releases/download/4.1/LinVst-64bit-32bit_4.1.0.deb
wget -O glyphr-studio_amd64.deb https://github.com/glyphr-studio/Glyphr-Studio-Desktop/releases/download/v0.5.6/glyphr-studio-desktop_0.5.6_amd64.deb
wget https://zoomgov.com/client/latest/zoom_amd64.deb
#installing...
sudo apt install ./code_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb 
sudo apt install ./dropbox_amd64.deb
sudo apt install ./ulauncher_all.deb
sudo apt install ./polyphone_amd64.deb
sudo apt install ./appimagelauncher_amd64.deb
sudo apt install ./LinVst_amd64.deb
sudo apt install ./glyphr-studio_amd64.deb
sudo apt install ./zoom_amd64.deb

# SPANISH LANGUAGE
sudo apt install -y language-pack-gnome-es language-pack-kde-es aspell-es $(check-language-support)

# PERMISSIONS
# Add me to any groups I might need to be a part of:
sudo adduser $USER www-data
sudo adduser $USER vboxusers
# -- default ubuntu groups --
# adm cdrom sudo audio dip www-data plugdev lpadmin lxd sambashare vboxusers
# Permissions on public_html folder on $HOME directory, where I usually 
sudo chown -R www-data:www-data /var/www/
sudo chmod -R g+rwX /var/www/
sudo chown -R www-data:www-data $HOME/public_html/
sudo chmod -R g+rwX $HOME/public_html/

#FLATPAKS
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub org.gimp.GIMP org.gtk.Gtk3theme.Arc-Dark

# FINAL STEPS
# Install TLP for laptops
#sudo apt install -y tlp tlp-rdw
#sudo tlp start
# Remove unused software
sudo apt purge -y qpdfview qtpass featherpad 2048-qt trojita quassel qterminal lximage-qt screengrab transmission-qt -yy && sudo apt autoremove
# Disable Apache and Mysql services at boot
sudo systemctl disable apache2
sudo systemctl disable mysql.service
# Some cleanning
# Delete DPK installers
rm -r *.deb
# APT Autoremove
sudo apt autoremove -y
# Final APT update
sudo apt update && sudo apt upgrade -y
# Gotta reboot now:
echo $'\n'$"*** Reboot now. ***"
