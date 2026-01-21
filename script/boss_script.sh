#!/bin/bash

echo "🚀 Starting all scripts at $(date)..."

DOTFILES_DIR="$HOME/.dotfiles"
ALIAS_DEST="$HOME/.aliases.sh"

echo "📦 Cloning git repo …"
git clone "https://github.com/Kal-sh/.dotfiles.git" "DOTFILES_DIR"

run_script() {
  echo "⏱️  [$(date)] ➤ Running $1…"
  ./"$1"
  echo "🎯 [$(date)] ✔ Finished $1."
}

cd "DOTFILES_DIR"

echo "📦 adding git remote origin"
git remote add origin git@github.com:Kal-sh/.dotfiles.git
git remote set-url origin git@github.com:Kal-sh/.dotfiles.git

cd "DOTFILES_DIR/script/"

echo "👉 Now running install-script.sh"
run_script install-script.sh

echo "👉 Now running install-flatpaks.sh"
run_script install-flatpaks.sh

#echo "👉 Now running zsh4humans.sh"
#run_script zsh4humans.sh

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
  if [[ -e "$ALIAS_DEST" || -L "$ALIAS_DEST" ]]; then
    echo "🗑️ Removing existing file/link: $ALIAS_DEST"
    rm -rf "$ALIAS_DEST"
  fi
  echo "🔗 Creating symlink: $ALIAS_DEST → $ALIAS_SRC"
  ln -s "$ALIAS_SRC" "$ALIAS_DEST"
else
  echo "⚠️  No distro-specific alias found for: $DISTRO"
fi

echo "🧹 Removing conflicting files in HOME before stow…"
# Remove files that would conflict with stow
# Only remove if they are regular files or symlinks
files=(
  .zshrc
  .zshenv
  .bashrc
  .bash_profile
  .p10k.zsh
  .gitconfig
)

for f in "${files[@]}"; do
  if [[ -e "$HOME/$f" || -L "$HOME/$f" ]]; then
    echo "🗑️  Removing ~/${f}"
    rm -rf "$HOME/$f"
  fi
done

echo "🛠️  Running stow for dotfiles…"
cd "$DOTFILES_DIR"
stow . --ignore='^script$' || {
  echo "❌ Stow encountered an error!"
  exit 1
}

echo "🎉 Alias linking and stow complete!"

wait
echo "🏁 All done at $(date)! 🎉"
