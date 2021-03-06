#!/bin/sh

# VOID SETUP SCRIPT
WM=$1

if [ "$WM" = "" ]; then
	echo "Please specify a WM"
	exit 1
fi

# Install base packages
sudo xbps-install -Sy acpi alsa-firmware alsa-tools alsa-utils base-devel chromium cifs-utils cmake curl dbus-glib dmenu feh ffmpeg font-symbola fonts-nanum-ttf fonts-nanum-ttf-extra gimp git htop inxi ipafont-fonts-otf libX11-devel libXft-devel libXinerama-devel libXmu-devel libXtst-devel lm_sensors maim mpv neofetch neovim plex-media-player psmisc ranger tmux wget xclip xcompmgr xorg xwallpaper zsh deadbeef deadbeef-fb deadbeef-waveform-seekbar

mkdir -p $HOME/git

# Build and install st
cd $HOME/git
git clone https://github.com/tylerpnn/st
cd st
git fetch origin $WM
git checkout $WM
make
sudo make install

if [ "$WM" = "dwm" ]; then
	# Build and install dwm
	cd $HOME/git
	git clone https://github.com/tylerpnn/dwm
	cd dwm
	make
	sudo make install

	# Install iwd
	sudo xbps-install -Sy iwd dbus
	sudo ln -s /etc/sv/dbus /var/service
	sudo ln -s /etc/sv/iwd /var/service
fi

if [ "$WM" = "kde5" ]; then
	sudo xbps-install -Sy kde5 dolphin udisks2 xdg-desktop-portal xdg-desktop-portal-gtk xdg-user-dirs xdg-user-dirs-gtk
	sudo ln -s /etc/sv/dbus /var/service
	sudo ln -s /etc/sv/sddm /var/service
	sudo usermod -a -G storage $USER
fi

# Clone dotfiles and copy the essential ones
cd $HOME/git
git clone https://github.com/tylerpnn/dotfiles_void
cd dotfiles_void
git fetch origin $WM
git checkout $WM
cp -f .* $HOME
cp -rf .config $HOME
cp -rf .local $HOME
cd $HOME
rm .zprofile .bash_profile
ln -s .profile .zprofile
ln -s .profile .bash_profile

# Download and install Discord
sudo xbps-install -Sy alsa-lib dbus-glib gtk+3 GConf libnotify nss libXtst libcxx libatomic
mkdir -p $HOME/Downloads
cd $HOME/Downloads
wget https://dl.discordapp.net/apps/linux/0.0.12/discord-0.0.12.tar.gz
tar -xzf ./discord-0.0.12.tar.gz
chmod +x ./Discord/Discord
sudo cp ./Discord/discord.desktop /usr/share/applications
sudo cp ./Discord/discord.png /usr/share/pixmaps
sudo mv ./Discord /usr/share/discord
sudo ln -s /usr/share/discord/Discord /usr/bin/discord

# Finally, change shell to zsh
chsh -s `which zsh` $USER
