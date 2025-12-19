#!/bin/bash

# 🚀 install-apps.sh — OS-aware installer with emojis

install_apps() {
  if [[ -f /etc/os-release ]]; then
    . /etc/os-release
    DISTRO=$ID
  fi

  echo "🧠 Detected distro: $DISTO"

  case $DISTRO in
  ubuntu | debian)
    echo "🐧 Ubuntu/Debian detected — updating & installing via apt…"
    sudo apt update && sudo apt upgrade -y

    apps=(
      curl
      vim
      git
      ufw
      stow
      ttf-hack-nerd
      tor
      ncdu
      nethogs
      gnome-tweaks
      ulauncher
    )

    for app in "${apps[@]}"; do
      if dpkg -l | grep -q "$app"; then
        echo "✅ $app already installed"
      else
        echo "⬇️ Installing $app…"
        sudo apt install -y "$app"
      fi
    done
    ;;

  arch | cachyos)
    echo "🏔️ Arch/Cachyos detected — updating & installing via pacman…"
    sudo pacman -Syu --noconfirm

    apps=(
      curl
      vim
      git
      ufw
      stow
      ttf-hack-nerd
      ncdu
      nethogs
      tor
      gnome-tweaks
    )

    for app in "${apps[@]}"; do
      if pacman -Qs "$app" >/dev/null; then
        echo "✅ $app already installed"
      else
        echo "⬇️ Installing $app…"
        sudo pacman -S --noconfirm "$app"
      fi
    done
    ;;

  *)
    echo "❌ Unsupported OS. Please use Ubuntu/Debian or Arch-based distros."
    exit 1
    ;;
  esac

  echo "🎉 All listed apps processed!"
}

install_apps
