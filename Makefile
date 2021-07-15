install:
	
# GNOME stuff
	sudo dnf install -y gnome-extensions-app gnome-tweaks
	sudo dnf install -y gnome-shell-extension-appindicator

# RPM 
#	sudo dnf install -y  https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
#	sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
	sudo dnf upgrade -y --refresh
	sudo dnf groupupdate -y core
#	sudo dnf install -y rpmfusion-free-release-tainted
	sudo dnf install -y dnf-plugins-core

# Flatpak
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	flatpak update -y

# Flatpak software
	flatpak install -y flathub com.spotify.Client
	flatpak install -y flathub com.discordapp.Discord
	flatpak install -y flathub com.valvesoftware.Steam
	flatpak install -y flathub com.github.micahflee.torbrowser-launcher
	flatpak install -y flathub com.visualstudio.code
	flatpak install -y flathub org.qbittorrent.qBittorrent
	flatpak install -y flathub com.jetbrains.CLion

# nvidia driver wizardry stuff idk
	sudo dnf install -y akmod-nvidia
	sudo dnf install -y xorg-x11-drv-nvidia-cuda
	sudo dnf install -y xorg-x11-drv-nvidia-cuda-libs
	sudo dnf install -y vdpauinfo libva-vdpau-driver libva-utils
	sudo dnf install -y vulkan

# DNF flags
	echo 'fastestmirror=1' | sudo tee -a /etc/dnf/dnf.conf
	echo 'max_parallel_downloads=10' | sudo tee -a /etc/dnf/dnf.conf
	echo 'deltarpm=true' | sudo tee -a /etc/dnf/dnf.conf

# Snap
	sudo dnf install -y snapd
	sudo ln -s /var/lib/snapd/snap /snap

# Misc

# Upgrade and reboot
	sudo dnf upgrade -y --refresh
	sudo dnf check
	sudo dnf autoremove -y
	sudo fwupdmgr get-devices
	sudo fwupdmgr refresh --force
	sudo fwupdmgr get-updates
	sudo fwupdmgr update
	systemctl reboot