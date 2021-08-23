#!/bin/bash
sudo dnf install -y cronie
systemctl enable crond.service
sudo crontab -l > mycron
sudo chmod 777 mycron
	
echo "*/20 * * * * mv ~/Downloads/*.mp4 ~/Videos/Video\ Memes" >> mycron
echo "*/20 * * * * mv ~/Downloads/*.mov ~/Videos/Video\ Memes" >> mycron
echo "*/20 * * * * mv ~/Downloads/*.webm ~/Videos/Video\ Memes" >> mycron
echo "0 */1 * * * mv ~/*.mp3 ~/Music" >> mycron
echo "0 */3 * * * sudo dnf update -y && sudo dnf upgrade -y" >> mycron
crontab mycron
rm mycron
systemctl start crond.service