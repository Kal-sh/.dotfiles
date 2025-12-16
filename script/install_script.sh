#!/bin/bash

# Function to check the OS and install the apps accordingly
install_apps() {
  if [[ -f /etc/os-release ]]; then
    . /etc/os-release
    DISTRO=$ID
  fi

  # Install applications based on distribution
  case $DISTRO in
  ubuntu | debian)
    echo "Detected Ubuntu/Debian. Installing apps using apt..."
    sudo apt update && sudo apt upgrade -y

    # List of applications to install
    apps=("curl" "vim" "git" "ufw" "stow" "tor" "ncdu" "nethogs" "gnome-tweaks" "ulauncher")

    for app in "${apps[@]}"; do
      echo "Installing $app..."
      sudo apt install -y $app
    done
    ;;

  arch | cachyos)
    echo "Detected Arch/Cachyos. Installing apps using pacman..."
    sudo pacman -Syu --noconfirm

    # List of applications to install
    apps=("curl" "vim" "git" "ufw" "stow" "ncdu" "nethogs" "tor" "gnome-tweaks") 

    for app in "${apps[@]}"; do
      echo "Installing $app..."
      sudo pacman -S --noconfirm $app
    done
    ;;

  *)
    echo "Unsupported OS. Please use either Ubuntu/Debian or Arch-based distributions."
    exit 1
    ;;
  esac
}

# Run the installation function
install_apps
