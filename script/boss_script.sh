#!/usr/bin/env bash
set -euo pipefail

echo "🚀 Starting tasks at $(date)..."

run_script() {
  echo "⏱️ [$(date)] Starting 🚧 $1..."
  ./"$1"
  if [ $? -eq 0 ]; then
    echo "✅ [$(date)] Finished 🎉 $1."
  else
    echo "❌ [$(date)] $1 failed 😢"
  fi
}

# —————————————
# bootstrap.sh logic
# —————————————

bootstrap_tasks() {
  echo "📁 Running bootstrap tasks…"

  # Detect distro
  if [[ -f /etc/os-release ]]; then
    . /etc/os-release
    DISTRO="${ID,,}"
  else
    DISTRO="unknown"
  fi

  DOTFILES_REPO="https://github.com/kal-sh/.dotfiles.git"
  DOTFILES_DIR="$HOME/.dotfiles"

  # Clone dotfiles
  if [ -d "$DOTFILES_DIR" ]; then
    echo "📌 Dotfiles directory exists — skipping clone."
  else
    echo "📦 Cloning dotfiles repo…"
    git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
  fi

  cd "$DOTFILES_DIR"

  # Deploy distro-specific alias
  echo "📂 Deploying distro-specific alias file…"
  case "$DISTRO" in
  arch | cachyos)
    ALIAS_SRC="$DOTFILES_DIR/script/arch_alias.sh"
    ;;
  ubuntu | debian)
    ALIAS_SRC="$DOTFILES_DIR/script/ubuntu_alias.sh"
    ;;
  fedora)
    ALIAS_SRC="$DOTFILES_DIR/script/fedora_alias.sh"
    ;;
  *)
    ALIAS_SRC=""
    ;;
  esac

  ALIAS_DEST="$HOME/.aliases.sh"

  if [[ -n "$ALIAS_SRC" && -f "$ALIAS_SRC" ]]; then
    if [[ -L "$ALIAS_DEST" || -e "$ALIAS_DEST" ]]; then
      echo "🔗 Alias link already exists: $ALIAS_DEST"
    else
      echo "🔗 Creating symlink: $ALIAS_DEST → $ALIAS_SRC"
      ln -s "$ALIAS_SRC" "$ALIAS_DEST"
    fi
  else
    echo "⚠️ No distro-specific alias found for: $DISTRO"
  fi

  # Run stow
  echo "📌 Running stow…"
  stow . --ignore='^script$'

  echo "🎉 Bootstrap tasks complete!"
}

run_script install-script.sh &
run_script install-flatpaks.sh &

wait
echo "🎯 All done at $(date)! 🎉"
