#!/bin/bash

echo "🚀 Starting all scripts at $(date)..."

echo "📦 Cloning git repo …"
git clone "https://github.com/Kal-sh/.dotfiles.git" "$HOME/.dotfiles"

run_script() {
  echo "⏱️  [$(date)] ➤ Running $1…"
  ./"$1"
  echo "🎯 [$(date)] ✔ Finished $1."
}

cd "$HOME/.dotfiles"

echo "📦 changing git remote to SSH"
git remote set-url origin git@github.com:Kal-sh/.dotfiles.git

cd "$HOME/.dotfiles/script/"

echo "👉 Now running install-script.sh"
run_script install-script.sh

echo "👉 Now running install-flatpaks.sh"
run_script install-flatpaks.sh

echo "👉 Now running install-script.sh"
run_script tor_config.sh

#echo "👉 Now running zsh4humans.sh (interactive - isolated terminal)"
#script -q -c "./zsh4humans.sh" /dev/null
#echo "🎯 zsh4humans installation complete."

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
  .local/share/ulauncher/extensions
  .config/VSCodium/User/keybindings.json
  .config/VSCodium/User/settings.json
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

echo "💩 dump extensions setting into dconf"
dconf load /org/gnome <~/.dotfiles/script/extensions.conf || echo "⚠️  dconf load failed (extensions may not be installed yet)"

echo "📦 Cloning git repo …"
git clone "https://github.com/Kal-sh/VS-Code-.git" "$HOME/Documents/Github/VS-Code-/"

echo "📦 changing git remote to SSH"
cd ~/Documents/Github/VS-Code-/
git remote set-url origin git@github.com:Kal-sh/VS-Code-.git
git switch In-progress

wait
echo "🏁 All done at $(date)! 🎉"
