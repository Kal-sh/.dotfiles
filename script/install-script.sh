#!/usr/bin/env bash
set -euo pipefail

echo "📦 Installing prerequisites…"

# Detect distro
if [[ -f /etc/os-release ]]; then
  . /etc/os-release
  DISTRO="${ID,,}"
else
  DISTRO="unknown"
fi

case "$DISTRO" in
ubuntu | debian)
  echo "🐧 Ubuntu/Debian detected — updating & installing apps…"
  sudo apt update && sudo apt upgrade -y

  apps=(
    curl
    vim-nox
    git
    ufw
    stow
    ttf-hack-nerd
    ghostty
    tor
    opencode
    ncdu
    nethogs
    tree-sitter-cli 
    nvim
    gnome-tweaks
    ulauncher
    vscodium
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
  echo "🏔️ Arch/Cachyos detected — updating & installing apps…"
  sudo pacman -Syu --noconfirm

  # Official Arch packages
  apps=(
    curl
    vim
    git
    ufw
    stow
    ttf-hack-nerd
    ghostty
    nvim
    tor
    ncdu
    nethogs
    tor
    gnome-tweaks
    tree-sitter-cli 
    #glow
    vscodium
  )

  for app in "${apps[@]}"; do
    if pacman -Qs "$app" >/dev/null; then
      echo "✅ $app already installed"
    else
      echo "⬇️ Installing $app…"
      sudo pacman -S --noconfirm "$app"
    fi
  done

  # AUR packages via paru (preinstalled as you said)
  aur_apps=(
    ulauncher
    opencode
    gnome-shell-pomodoro
  )

  for aur_app in "${aur_apps[@]}"; do
    if paru -Qs "$aur_app" >/dev/null; then
      echo "✅ $aur_app already installed (AUR)"
    else
      echo "⬇️ Installing $aur_app from AUR…"
      paru -S --noconfirm "$aur_app"
    fi
  done
  ;;

fedora)
  echo "🐧 Fedora detected — updating & installing apps…"
  sudo dnf update -y

  apps=(
    curl
    vim-enhanced
    git
    ufw
    stow
    ttf-hack-nerd
    ghostty
    tor
    nvim
    opencode-bin
    ncdu
    nethogs
    gnome-tweaks
    tree-sitter-cli 
    ulauncher
    vscodium
  )

  for app in "${apps[@]}"; do
    if rpm -q "$app" >/dev/null; then
      echo "✅ $app already installed"
    else
      echo "⬇️ Installing $app…"
      sudo dnf install -y "$app"
    fi
  done
  ;;

*)
  echo "❌ Unsupported OS. Exiting."
  exit 1
  ;;
esac

echo "🎉 App installation complete!"
