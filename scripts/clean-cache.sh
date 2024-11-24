#!/bin/bash
sudo apt-get autoclean
sudo apt-get clean
sudo apt-get autoremove --purge
sudo rm -rf ~/.cache
sudo rm -rf ~/.config/libreoffice/4/cache
sudo rm -rf ~/.thumbnail
sudo rm -rfv /var/tmp/flatpak-cache-*
flatpak uninstall --unused
