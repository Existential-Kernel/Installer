all: update folders GNOME RPM flatpak flatpak_software vscode extensions ffmpeg xcalib NVIDIA DNF snap crontab wine github systemctl

update:
	sudo dnf clean all
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
	flatpak install -y flathub org.qbittorrent.qBittorrent
	flatpak install -y flathub com.jetbrains.CLion
	flatpak install -y flathub io.github.seadve.Kooha
	flatpak install -y flathub org.ghidra_sre.Ghidra
	flatpak install -y flathub io.github.hakuneko.HakuNeko
	flatpak install -y flathub org.gnome.GHex
	flatpak install -y flathub com.github.reds.LogisimEvolution
	flatpak install -y flathub com.axosoft.GitKraken

vscode:
	echo "[vscode]" >> /etc/yum.repos.d/vscode.repo
	echo "name=Visual Studio Code" >> /etc/yum.repos.d/vscode.repo
	echo "baseurl=https://packages.microsoft.com/yumrepos/vscode" >> /etc/yum.repos.d/vscode.repo
	echo "enabled=1" >> /etc/yum.repos.d/vscode.repo
	echo "gpgcheck=1" >> /etc/yum.repos.d/vscode.repo
	echo "gpgkey=https://packages.microsoft.com/keys/microsoft.asc" >> /etc/yum.repos.d/vscode.repo

	sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
	sudo dnf -y install code

extensions:
	code --install-extension ms-vscode.cpptools
	code --install-extension akhail.save-typing
	code --install-extension gruntfuggly.discord-chat
	code --install-extension icrawl.discord-vscode
	code --install-extension pkief.material-icon-theme
	code --install-extension formulahendry.code-runner
	code --install-extension vscode.powershell
	code --install-extension eg2.vscode-npm-script
	code --install-extension github.vscode-pull-request-github
	code --install-extension naumovs.color-highlight
	code --install-extension ms-vscode.cmake-tools
	code --install-extension twxs.cmake
	code --install-extension aaron-bond.better-comments
	code --install-extension mikestead.dotenv
	code --install-extension yzhang.markdown-all-in-one
	code --install-extension danielpinto8zz6.c-cpp-compile-run
	code --install-extension james-yu.latex-workshop
	code --install-extension mhutchie.git-graph
	code --install-extension jeff-hykin.better-cpp-syntax
	code --install-extension damien.autoit
	code --install-extension mshr-h.veriloghdl
	code --install-extension kriegalex.vscode-cudacpp

ffmpeg:
	sudo dnf -y install ffmpeg
	sudo dnf -y install ffmpeg-devel

xcalib:
	sudo yum install xcalib -y
	alias invert="xcalib -invert -alter"

NVIDIA:
	sudo dnf install dnf-plugins-core -y
	sudo dnf copr enable t0xic0der/nvidia-auto-installer-for-fedora -y
	sudo dnf install nvautoinstall -y
	
	sudo nvautoinstall --rpmadd
	sudo nvautoinstall --driver
	sudo nvautoinstall --x86lib
	sudo nvautoinstall --nvrepo
	sudo nvautoinstall --plcuda
	sudo nvautoinstall --vulkan
	sudo nvautoinstall --ffmpeg

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
