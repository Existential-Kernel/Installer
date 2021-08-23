#!/bin/bash
echo $'# GDM configuration storage\n' > /etc/gdm/custom.conf
echo $'[daemon]' >> /etc/gdm/custom.conf
echo $'# Uncomment the line below to force the login screen to use Xorg\nWaylandEnable=false\n' >> /etc/gdm/custom.conf
echo $'[security]\n\n[xdmcp]\n\n[chooser]\n\n[debug]\n# Uncomment the line below to turn on debugging\n#Enable=true' >> /etc/gdm/custom.conf