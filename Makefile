all: update folders GNOME RPM flatpak flatpak_software vscode extensions software NVIDIA DNF snap crontab wine github Xorg systemctl

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
	flatpak install -y flathub io.qt.QtCreator
	flatpak install -y flathub org.librepcb.LibrePCB
	flatpak install -y flathub io.github.shiftey.Desktop
	flatpak install -y flathub io.github.Figma_Linux.figma_linux
	flatpak install -y flathub org.gimp.GIMP

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
	code --install-extension icrawl.discord-vscode
	code --install-extension pkief.material-icon-theme
	code --install-extension formulahendry.code-runner
	code --install-extension eg2.vscode-npm-script
	code --install-extension github.vscode-pull-request-github
	code --install-extension naumovs.color-highlight
	code --install-extension ms-vscode.cmake-tools
	code --install-extension twxs.cmake
	code --install-extension aaron-bond.better-comments
	code --install-extension mikestead.dotenv
	code --install-extension bierner.markdown-preview-github-styles
	code --install-extension danielpinto8zz6.c-cpp-compile-run
	code --install-extension james-yu.latex-workshop
	code --install-extension mhutchie.git-graph
	code --install-extension jeff-hykin.better-cpp-syntax
	code --install-extension damien.autoit
	code --install-extension mshr-h.veriloghdl
	code --install-extension kriegalex.vscode-cudacpp
	code --install-extension tialki.tex-preview
	code --install-extension jeff-tian.tex-workshop
	code --install-extension tomoki1207.pdf
	code --install-extension ms-vscode.makefile-tools
	code --install-extension 13xforever.language-x86-64-assembly
	code --install-extension xsro.masm-tasm
	code --install-extension azuretools.vscode-docker
	code --install-extension teledemic.branch-warnings

software:
	sudo dnf -y install ffmpeg
	sudo dnf -y install ffmpeg-devel
	sudo yum install xcalib -y
	sudo curl https://packages.microsoft.com/config/rhel/7/prod.repo | sudo tee /etc/yum.repos.d/microsoft.repo
	sudo yum install -y powershell
	sudo dnf -y install discord
	sudo dnf -y install steam
	sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
	sudo dnf -y install gh

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
	
CUDA:
	export CUDA_HOME=/usr/local/cuda
	export PATH=${CUDA_HOME}/bin:${PATH}
	export LD_LIBRARY_PATH=${CUDA_HOME}/lib64:$LD_LIBRARY_PATH

discord:
	echo "{" >> ~/.config/discord/settings.json 
	echo '"BACKGROUND_COLOR": "#202225",' >> ~/.config/discord/settings.json
	echo '"IS_MAXIMIZED": false,' >> ~/.config/discord/settings.json
	echo '"IS_MINIMIZED": false,' >> ~/.config/discord/settings.json
	echo '"DANGEROUS_ENABLE_DEVTOOLS_ONLY_ENABLE_IF_YOU_KNOW_WHAT_YOURE_DOING": true,' >> ~/.config/discord/settings.json
	echo '"WINDOW_BOUNDS": {' >> ~/.config/discord/settings.json
	echo '"x": 320,' >> ~/.config/discord/settings.json
	echo '"y": 270,' >> ~/.config/discord/settings.json
	echo '"width": 1280,' >> ~/.config/discord/settings.json
	echo '"height": 720' >> ~/.config/discord/settings.json
	echo '}' >> ~/.config/discord/settings.json
	echo '}' >> ~/.config/discord/settings.json

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

Xorg:
	sudo chmod u+x shell/xorg.sh
	./shell/xorg.sh

systemctl:
	sudo dnf upgrade -y --refresh
	sudo dnf check
	sudo dnf autoremove -y
	systemctl reboot
