#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Custom functions

grepcat() {
  grep "$1" "$2"
}

jctl_err() {
  journalctl -u "$1" -p err -n 5
}

jctl_live() {
  journalctl -u "$1" -f
}

searchpkg() {
  echo "=== Pacman ==="
  pacman -Ss "$1" | grep -w "$1"
  echo "=== Paru ==="
  paru -Ss "$1" | grep -w "$1"
}

update() {
  echo "=== Pacman ==="
  sudo pacman -Syu
  echo "=== Paru ==="
  paru -Sua
  echo "=== flatpak ==="
  flatpak update
}

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
