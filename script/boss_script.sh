#!/bin/bash

echo "🚀 Starting all scripts at $(date)..."

echo "📦 Cloning git repo …"
git clone "https://github.com/Kal-sh/.dotfiles.git" "$HOME/.dotfiles"

run_script() {
  echo "⏱️  [$(date)] ➤ Running $1…"
  ./"$1"
  echo "🎯 [$(date)] ✔ Finished $1."
}

cd "$HOME/.dotfiles/script/"

echo "👉 Now running install-script.sh"
run_script install-script.sh

echo "👉 Now running install-flatpaks.sh"
run_script install-flatpaks.sh

# —————————————
# Alias linking + Stow (added as requested)
# —————————————

echo "📂 Setting up alias link and running stow…"

# Detect distro
if [[ -f /etc/os-release ]]; then
  . /etc/os-release
  DISTRO="${ID,,}"
else
  DISTRO="unknown"
fi

DOTFILES_DIR="$HOME/.dotfiles"
ALIAS_DEST="$HOME/.aliases.sh"

echo "🔍 Deploying distro-specific alias file for $DISTRO…"
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

if [[ -n "$ALIAS_SRC" && -f "$ALIAS_SRC" ]]; then
  if [[ -L "$ALIAS_DEST" || -e "$ALIAS_DEST" ]]; then
    echo "🔗 Alias link already exists: $ALIAS_DEST"
  else
    echo "🔗 Creating symlink: $ALIAS_DEST → $ALIAS_SRC"
    ln -s "$ALIAS_SRC" "$ALIAS_DEST"
  fi
else
  echo "⚠️  No distro-specific alias found for: $DISTRO"
fi

echo "🛠️  Running stow for dotfiles…"
cd "$DOTFILES_DIR"
stow . --ignore='^script$' || {
  echo "❌ Stow encountered an error!"
  exit 1
}

echo "🎉 Alias linking and stow complete!"

wait
echo "🏁 All done at $(date)! 🎉"
