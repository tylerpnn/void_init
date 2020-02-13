#!/bin/sh

# VOID SETUP SCRIPT
HOME=/home/tyler

# Install base packages
sudo xbps-install -Sy alsa-utils base-devel chromium cifs-utils cmake curl feh ffmpeg font-symbola fonts-nanum-ttf fonts-nanum-ttf-extra gimp git htop inxi ipafont-fonts-otf libX11-devel libXft-devel libXinerama-devel lm_sensors maim neofetch neovim plex-media-player ranger tmux xclip xorg zsh wget xcompmgr xorg-fonts xwallpaper mpv dmenu

if [ "$1" = "--laptop" ]; then
	sudo xbps-install -Sy acpi xf86-video-intel
fi

mkdir -p $HOME/git
cd $HOME/git

# Build and install st
git clone https://github.com/lukesmithxyz/st
cd ./st
make
sudo make install
cd ..

# Build and install dwm
git clone https://github.com/tylerpnn/dwm
cd ./dwm
make
sudo make install
cd ..

# Clone dotfiles and copy the essential ones
git clone https://github.com/tylerpnn/dotfiles_void
mkdir -p $HOME/.config
mkdir -p $HOME/.local
cd ./dotfiles_void
cp -r ./.local/scripts $HOME/.local
cp -r ./.local/share $HOME/.local
cp -r ./.config/nvim $HOME/.config
cp -r ./.config/zsh $HOME/.config
cp ./.config/wall.png $HOME/.config
cp ./.xinitrc $HOME/.xinitrc
cp ./.bashrc $HOME/.bashrc
cp ./.xprofile $HOME/.xprofile
cp ./.profile $HOME/.profile
cd $HOME
rm .zprofile .bash_profile
ln -s .profile .zprofile
ln -s .profile .bash_profile

# Download and install Discord
sudo xbps-install -Sy alsa-lib dbus-glib gtk+3 GConf libnotify nss libXtst libcxx libatomic
mkdir -p $HOME/Downloads
cd $HOME/Downloads
wget https://dl.discordapp.net/apps/linux/0.0.9/discord-0.0.9.tar.gz
tar -xzf ./discord-0.0.9.tar.gz
chmod +x ./Discord/Discord
sudo cp ./Discord/discord.desktop /usr/share/applications
sudo cp ./Discord/discord.png /usr/share/pixmaps
sudo mv ./Discord /usr/share/discord
sudo ln -s /usr/share/discord/Discord /usr/bin/Discord
