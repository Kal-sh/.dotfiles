#!/bin/bash

set -e

echo "=== Ubuntu Desktop GUI Removal + SSH Setup Script ==="
echo "This will remove GNOME, gdm3, and Desktop packages,"
echo "install & enable OpenSSH Server, and switch to console mode."
echo "Your Wi-Fi drivers and firmware will be kept."
echo ""
read -p "Press ENTER to continue or CTRL+C to abort..."

echo ">>> Ensuring OpenSSH Server is installed..."
sudo apt update
sudo apt install -y openssh-server

echo ">>> Enabling SSH service..."
sudo systemctl enable ssh
sudo systemctl start ssh

echo ">>> Switching system to console (multi-user) mode..."
sudo systemctl set-default multi-user.target

echo ">>> Disabling gdm3..."
sudo systemctl disable gdm3 || true

echo ">>> Purging Ubuntu Desktop metapackages..."
sudo apt purge -y ubuntu-desktop ubuntu-desktop-minimal gnome-shell gdm3

echo ">>> Removing GNOME applications..."
sudo apt purge -y \
  gnome-software gnome-terminal gedit gnome-control-center \
  nautilus yelp ubuntu-docs evince eog \
  gnome-system-monitor gnome-settings-daemon gnome-online-accounts

echo ">>> Removing other graphical packages..."
sudo apt purge -y \
  adwaita-icon-theme* gnome-themes-extra* \
  gnome-session* gnome-startup-applications* \
  gnome-menus gnome-keyring seahorse \
  gnome-screensaver gnome-backgrounds

echo ">>> Removing leftover display components..."
sudo apt purge -y \
  xserver-xorg* xwayland* wayland-protocols \
  mutter gnome-shell-common

echo ">>> Cleaning up unused dependencies..."
sudo apt autoremove -y --purge

echo ">>> Cleaning APT cache..."
sudo apt clean

echo ""
echo "=== GUI removal and SSH setup complete ==="

echo ">>> Detecting IP address for SSH..."
IP=$(hostname -I | awk '{print $1}')
echo "You can now SSH into this machine from another device using:"
echo ""
echo "    ssh $USER@$IP"
echo ""
echo "Rebooting in 5 seconds..."
sleep 5
sudo reboot

