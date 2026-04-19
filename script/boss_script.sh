#!/usr/bin/env bash
set -euo pipefail

log() { echo "📌 $*"; }
error() {
  echo "❌ $*" >&2
  exit 1
}

DOTFILES_REPO="https://github.com/Kal-sh/.dotfiles.git"
DOTFILES_SSH="git@github.com:Kal-sh/.dotfiles.git"
DOTFILES_DIR="$HOME/.dotfiles"

VS_CODE_REPO="https://github.com/Kal-sh/VS-Code-.git"
VS_CODE_SSH="git@github.com:Kal-sh/VS-Code-.git"
VS_CODE_DIR="$HOME/Documents/Github/VS-Code-/"

PROJECT_REPO="https://github.com/Kal-sh/project.git"
PROJECT_SSH="git@github.com:Kal-sh/project.git"
PROJECT_DIR="$HOME/Documents/Github/project/"

run_script() {
  local script="$1"
  log "Running $script"
  if [[ ! -f "$script" ]]; then
    error "$script not found!"
  fi
  chmod +x "$script"
  ./"$script"
  log "Finished $script"
}

# --- Clone and set SSH remote if needed
clone_and_set_remote() {
  local url_https="$1"
  local url_ssh="$2"
  local target="$3"

  mkdir -p "$(dirname "$target")"

  if [[ -d "$target/.git" ]]; then
    log "Repo already exists at $target"
    cd "$target"
    current=$(git remote get-url origin)
    if [[ "$current" != "$url_ssh" ]]; then
      log "Updating remote origin to SSH ($url_ssh)"
      git remote set-url origin "$url_ssh"
    else
      log "Remote origin already uses SSH"
    fi
    cd - >/dev/null
  else
    log "Cloning $url_https into $target"
    git clone "$url_https" "$target"
    cd "$target"
    log "Switching remote to SSH"
    git remote set-url origin "$url_ssh"
    cd - >/dev/null
  fi
}

log "🚀 Starting all scripts at $(date)"

# --- Clone and configure dotfiles
clone_and_set_remote "$DOTFILES_REPO" "$DOTFILES_SSH" "$DOTFILES_DIR"
cd "$DOTFILES_DIR"

# --- Run setup scripts
cd "$DOTFILES_DIR/script" || error "Script directory not found"
run_script install-script.sh
run_script install-flatpaks.sh

# --- Distro-specific alias linking
log "Setting up distro aliases"
if [[ -f /etc/os-release ]]; then
  . /etc/os-release
  DISTRO="${ID,,}"
else
  DISTRO="unknown"
fi

ALIAS_DEST="$HOME/.aliases.sh"
case "$DISTRO" in
arch | cachyos) ALIAS_SRC="$DOTFILES_DIR/script/arch_alias.sh" ;;
ubuntu | debian) ALIAS_SRC="$DOTFILES_DIR/script/ubuntu_alias.sh" ;;
fedora) ALIAS_SRC="$DOTFILES_DIR/script/fedora_alias.sh" ;;
*) ALIAS_SRC="" ;;
esac

if [[ -n "$ALIAS_SRC" && -f "$ALIAS_SRC" ]]; then
  log "Linking aliases for $DISTRO"
  rm -f "$ALIAS_DEST"
  ln -s "$ALIAS_SRC" "$ALIAS_DEST"
else
  log "No alias file found for $DISTRO"
fi

# --- Remove conflicting files safely
log "Removing conflicting dotfiles"
conflicts=(
  .zshrc .zshenv .bashrc .bash_profile .p10k.zsh
  .gitconfig
  .local/share/ulauncher/extensions
  .config/VSCodium/User/keybindings.json
  .config/VSCodium/User/settings.json
)

for f in "${conflicts[@]}"; do
  target="$HOME/$f"
  if [[ -e "$target" || -L "$target" ]]; then
    log "Removing $target"
    rm -rf "$target"
  fi
done

# --- Clone VS Code config
clone_and_set_remote "$VS_CODE_REPO" "$VS_CODE_SSH" "$VS_CODE_DIR"
cd "$VS_CODE_DIR"
git switch In-progress || log "Branch In-progress may not exist"
cd - >/dev/null

# --- Clone Project repo
clone_and_set_remote "$PROJECT_REPO" "$PROJECT_SSH" "$PROJECT_DIR"
cd "$PROJECT_DIR"
git switch in-progress-proj || log "Branch main may not exist"
cd - >/dev/null

# --- GNU Stow
log "Running stow"
cd "$DOTFILES_DIR"
stow . --ignore='^script$' || error "Stow failed"

# --- Devbox
cd "$DOTFILES_DIR/script" || error
run_script devbox.sh

# --- GNOME dconf
log "Applying dconf settings"
dconf load /org/gnome <"$DOTFILES_DIR/script/extensions.conf" ||
  log "dconf failed — maybe extensions not installed yet"

log "🏁 All done at $(date)! 🎉"
