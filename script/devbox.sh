#!/usr/bin/env bash
set -euo pipefail

BOX_NAME="devbox"
IMAGE="quay.io/toolbx/arch-toolbox:latest"

PACKAGES=(
  fd
  eza
  fzf
  git
  vim
  curl
  ncdu
  neovim
  nodejs
  npm
  python
  ttyper
  zoxide
  lazygit
  ripgrep
  opencode
  tealdeer
  wl-clipboard
  ttf-hack-nerd
  tree-sitter-cli
)

# 👇 apps/binaries you want exported to host
EXPORT_BINS=(
  rg
  eza
  vim
  nvim
  ncdu
  stow
  tldr
  ttyper
  zoxide
  lazygit
  opencode
  tealdeer
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
  npm setup || true
  mkdir -p ~/.npm-global
  npm config set prefix ~/.npm-global
  npm install -g live-server 

  echo '📤 Exporting binaries to host…'

  for bin in ${EXPORT_BINS[*]}; do
    if command -v \$bin >/dev/null 2>&1; then
      echo \"➡️ Exporting \$bin\"
      distrobox-export --bin \$(command -v \$bin) --export-path ~/.local/bin
    else
      echo \"⚠️ Skipping \$bin (not found)\"
    fi
  done

  echo '🎉 Devbox setup finished inside container!'
"

echo "✅ Dev environment ready!"
echo "👉 Enter it with: distrobox enter $BOX_NAME"
