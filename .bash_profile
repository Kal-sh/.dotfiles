#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Custom functions

grepcat() {
  grep "$1" "$2"
}

# Defination
define() {
  local word="$*"
  curl -s "dict://dict.org/d:${word}" | grep -v '^[0-9]' | head -20
}
word() {
  local word="$*"
  curl -s "https://api.dictionaryapi.dev/api/v2/entries/en/${word}" |
    jq -r '.[0].meanings[].definitions[].definition' 2>/dev/null
}

# Logging
jctl_err() {
  journalctl -u "$1" -p err -n 5
}

jctl_live() {
  journalctl -u "$1" -f
}

watch_port() {
  watch "ss -tnp | grep $1"
}

# Distrobox
distrobox_export() {
  distrobox-export --bin /usr/bin/"$1" --export-path ~/.local/bin
}

distrobox_export_remove() {
  distrobox-export --bin /usr/bin/"$1" --delete
}

# Arch search and update
#searchpkg() {
#  echo "=== Pacman ==="
#  pacman -Ss "$1" | grep -w "$1"
#  echo "=== Paru ==="
#  paru -Ss "$1" | grep -w "$1"
#}

#update() {
#  echo "=== Pacman ==="
#  sudo pacman -Syu
#  echo "=== Paru ==="
#  paru -Sua
#  echo "=== flatpak ==="
#  flatpak update
#}

# File and Directory fuzzy search
fd_dir() {
  local selected_dir
  selected_dir=$(fd --type d --hidden --exclude .git | fzf-tmux -p -w 90% --reverse --preview 'ls -la --color=always {}')

  if [[ -n "$selected_dir" ]]; then
    cd "$selected_dir"
  fi
}

fdn_dir() {
  local selected_dir
  selected_dir=$(fd --type d --hidden --exclude .git | fzf-tmux -p -w 90% --reverse --preview 'ls -la --color=always {}')

  if [[ -n "$selected_dir" ]]; then
    xdg-open "$selected_dir"
  fi
}

fn_file() {
  local selected_file
  selected_file=$(fd --type f --hidden --exclude .git | fzf-tmux -p -w 90% --reverse --preview 'ls -la --color=always {}')

  if [[ -n "$selected_file" ]]; then
    # Get the directory of the selected file
    selected_dir=$(dirname "$selected_file")
    cd "$selected_dir"
  fi
}

fd_file() {
  local selected_file
  selected_file=$(fd --type f --hidden --exclude .git | fzf-tmux -p -w 90% --reverse --preview "bat --color=always {}")

  if [[ -n "$selected_file" ]]; then
    # Document files (PDFs, presentations, word docs)
    if [[ "$selected_file" =~ \.(pdf|ppt|pptx|doc|docx)$ ]]; then
      xdg-open "$selected_file"

    # Image files
    elif [[ "$selected_file" =~ \.(jpg|jpeg|png|gif|bmp|svg|webp)$ ]]; then
      xdg-open "$selected_file"

    # Video files
    elif [[ "$selected_file" =~ \.(mp4|mkv|webm|avi|mov|flv)$ ]]; then
      xdg-open "$selected_file"

    # Audio files
    elif [[ "$selected_file" =~ \.(mp3|wav|flac|ogg|m4a)$ ]]; then
      xdg-open "$selected_file"

    # Archive files (optional - could be added later)
    # elif [[ "$selected_file" =~ \.(zip|tar|gz|7z|rar)$ ]]; then
    #     xdg-open "$selected_file"

    # All other files - open with nvim
    else
      nvim "$selected_file"
    fi
  fi
}
