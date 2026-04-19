#!/usr/bin/env bash
set -euo pipefail

BOX_NAME="devbox"

# 👇 Detect OS using /etc/os-release (standard way)
if [ -f /etc/os-release ]; then
  . /etc/os-release
  DISTRO=$ID
else
  echo "❌ Cannot detect OS"
  exit 1
fi

echo "🧠 Detected distro: $DISTRO"

# 👇 Defaults
IMAGE=""
UPDATE_CMD=""
INSTALL_CMD=""

case "$DISTRO" in
arch)
  IMAGE="quay.io/toolbx/arch-toolbox:latest"
  UPDATE_CMD="sudo pacman -Syu --noconfirm"
  INSTALL_CMD="sudo pacman -S --needed --noconfirm"
  ;;
fedora)
  IMAGE="registry.fedoraproject.org/fedora-toolbox:latest"
  UPDATE_CMD="sudo dnf upgrade -y"
  INSTALL_CMD="sudo dnf install -y"
  ;;
*)
  echo "⚠️ Unsupported distro: $DISTRO"
  echo "👉 Defaulting to Fedora toolbox"
  IMAGE="registry.fedoraproject.org/fedora-toolbox:latest"
  UPDATE_CMD="sudo dnf upgrade -y"
  INSTALL_CMD="sudo dnf install -y"
  ;;
esac

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

# 👇 apps to export
EXPORT_BINS=(
  nvim
  vim
  eza
  stow
  opencode
  zoxide
  gnome-tweaks
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
  $UPDATE_CMD

  echo '📦 Installing needed packages…'
  $INSTALL_CMD ${PACKAGES[*]}

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
