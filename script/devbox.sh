#!/usr/bin/env bash
set -euo pipefail

BOX_NAME="devbox"
IMAGE="quay.io/toolbx/arch-toolbox:latest"

PACKAGES=(
  curl
  vim
  git
  ttf-hack-nerd
  neovim
  wl-clipboard
  tree-sitter-cli
  zoxide
  python
  nodejs
  fd
  fzf
  eza
  opencode
  npm
  ripgrep
)

echo "📦 Checking if distrobox exists..."

if ! distrobox list | grep -q "$BOX_NAME"; then
  echo "🚀 Creating distrobox: $BOX_NAME"
  distrobox create \
    --name "$BOX_NAME" \
    --image "$IMAGE" \
    --pull \
    --yes
else
  echo "✅ Distrobox already exists"
fi

echo "⬇️ Installing dev environment inside $BOX_NAME..."

distrobox enter "$BOX_NAME" -- bash -c "
  set -e

  echo '🔄 Updating system…'
  sudo pacman -Syu --noconfirm

  echo '📦 Installing needed packages…'
  sudo pacman -S --needed --noconfirm ${PACKAGES[*]}

  echo '⬇️ Installing global npm tools…'
  # Ensure pnpm’s global directory is created and install global tools
  npm setup || true
  mkdir -p ~/.npm-global
  npm config set prefix "~/.npm-global"
  npm install -g live-server 

  echo '🎉 Devbox setup finished inside container!'
"

echo "✅ Dev environment ready!"
echo "👉 Enter it with: distrobox enter $BOX_NAME"
