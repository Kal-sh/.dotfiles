#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

grepcat() {
  cat "$1" | grep "$2"
}

fd_dir() {
    local selected_dir
    selected_dir=$(fdfind --type d --hidden --exclude .git | fzf-tmux -p -w 90% --reverse --preview 'exa -la --color=always {}')
    
    if [[ -n "$selected_dir" ]]; then
        cd "$selected_dir"
    fi
}

fdn_dir() {
    local selected_dir
    selected_dir=$(fdfind --type d --hidden --exclude .git | fzf-tmux -p -w 90% --reverse --preview 'exa -la --color=always {}')
    
    if [[ -n "$selected_dir" ]]; then
        xdg-open "$selected_dir"
    fi
}

fd_file() {
    local selected_file
    selected_file=$(fdfind --type f --hidden --exclude .git | fzf-tmux -p -w 90% --reverse --preview "batcat --color=always {}")
    
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


