all: folders GNOME RPM flatpak flatpak_software ffmpeg NVIDIA DNF snap crontab wine github systemctl

update:
	sudo dnf update -y

folders:
	sudo chmod u+x shell/folders.sh
	./shell/folders.sh

GNOME:
	sudo dnf install -y gnome-extensions-app gnome-tweaks
	sudo dnf install -y gnome-shell-extension-appindicator

RPM:
	sudo chmod u+x shell/RPM.sh
	./shell/RPM.sh
	sudo dnf upgrade -y --refresh
	sudo dnf groupupdate -y core
	sudo dnf install -y dnf-plugins-core

flatpak:
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	flatpak update -y

flatpak_software:
	flatpak install -y flathub com.spotify.Client
	flatpak install -y flathub com.discordapp.Discord
	flatpak install -y flathub com.valvesoftware.Steam
	flatpak install -y flathub com.github.micahflee.torbrowser-launcher
	flatpak install -y flathub com.visualstudio.code
	flatpak install -y flathub org.qbittorrent.qBittorrent
	flatpak install -y flathub com.jetbrains.CLion
	flatpak install -y flathub io.github.seadve.Kooha
	flatpak install -y flathub org.ghidra_sre.Ghidra
	flatpak install -y flathub io.github.hakuneko.HakuNeko
	flatpak install -y flathub org.gnome.GHex
	flatpak install -y flathub com.github.reds.LogisimEvolution
	flatpak install -y flathub com.axosoft.GitKraken

ffmpeg:
	sudo dnf -y install ffmpeg
	sudo dnf -y install ffmpeg-devel

NVIDIA:
	sudo dnf install -y akmod-nvidia
	sudo dnf install -y xorg-x11-drv-nvidia-cuda
	sudo dnf install -y xorg-x11-drv-nvidia-cuda-libs
	sudo dnf install -y vdpauinfo libva-vdpau-driver libva-utils
	sudo dnf install -y vulkan

DNF:
	echo 'fastestmirror=1' | sudo tee -a /etc/dnf/dnf.conf
	echo 'max_parallel_downloads=10' | sudo tee -a /etc/dnf/dnf.conf
	echo 'deltarpm=true' | sudo tee -a /etc/dnf/dnf.conf

snap:
	sudo dnf install -y snapd
	sudo ln -s /var/lib/snapd/snap /snap

crontab:
	sudo chmod u+x shell/crontab.sh
	./shell/crontab.sh

wine:
	sudo dnf -y install dnf-plugins-core
	sudo dnf config-manager --add-repo https://dl.winehq.org/wine-builds/fedora/34/winehq.repo
	sudo dnf -y install winehq-stable
	wget  https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
	chmod +x winetricks
	sudo mv winetricks /usr/local/bin/

github:
	sudo chmod u+x shell/github.sh
	./shell/github.sh

systemctl:
	sudo dnf upgrade -y --refresh
	sudo dnf check
	sudo dnf autoremove -y
	systemctl reboot
