# ─────────────────────────────────────────
# Package Manager (CachyOS)
# ─────────────────────────────────────────

# ─────────────────────────────────────────
# Pacman
# ─────────────────────────────────────────
alias update="sudo pacman -Syu"
alias s="pacman -Ss"
alias i="sudo pacman -S"
alias rmi="sudo pacman -Rs"
alias cc="sudo pacman -Sc"
alias cln="sudo pacman -Rns $(pacman -Qdtq)"
alias clean="cln && cc"
alias installed="pacman -Qe"
alias repo="pacman -Ql"

# ─────────────────────────────────────────
# CachyOS pacman wrapper
# ─────────────────────────────────────────
alias ref="sudo pacman -Fy" # update file database

# ─────────────────────────────────────────
# AUR helper (paru)
# ─────────────────────────────────────────
alias p="paru"
alias pi="paru -S"
alias pru="paru -Rs"
alias psyu="paru -Syu"

# ─────────────────────────────────────────
# System / General
# ─────────────────────────────────────────
alias sys="sudo systemctl"
alias q="exit"
alias cl="clear"
#alias ff="fd --type f --hidden --exclude .git | fzf-tmux -p -w 90% --reverse --preview 'bat --color=always {}' | xargs -I {} xdg-open '{}'"
#alias fn="fd --type f --hidden --exclude .git | fzf-tmux -p -w 90% --reverse --preview 'bat --color=always {}' | xargs nvim"
alias ff='fd --type f --hidden --exclude .git | fzf-tmux -p -w 90% --reverse --preview "bat --color=always {}" | { read -r file && [ -n "$file" ] && case "$file" in *.pdf) xdg-open "$file" ;; *.ppt|*.pptx) xdg-open "$file" ;; *.doc|*.docx) xdg-open "$file" ;; *.jpg|*.jpeg|*.png) xdg-open "$file" ;; *.mp4|*.mkv|*.webm) xdg-open "$file" ;; *) nvim "$file" ;; esac }'

# ─────────────────────────────────────────
# Toolbox / Distrobox (only if you installed them manually)
# ─────────────────────────────────────────
alias tb="toolbox enter"
alias tbl="toolbox list"
alias tbc="toolbox create"
alias tbs="podman container stop"
alias tbr="toolbox rm -f"

alias dbe="distrobox enter"
alias dbl="distrobox list"
alias dbc="distrobox create"
alias dbs="distrobox stop"
alias drm="distrobox rm -f"

# ─────────────────────────────────────────
# CLI Tools
# ─────────────────────────────────────────
alias ls="lsd -A"
alias lsa="lsd -lA"
alias bp="bpytop"
alias td="tldr"
alias st="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -"
alias fk="fuck"
alias nc="ncdu"
alias xd="xdg-open"
alias e="vim"
alias lol="lolcat"
alias n="nvim"
alias y="yazi"

# ─────────────────────────────────────────
# Tmux
# ─────────────────────────────────────────
alias t="tmux"
alias tl="tmux ls"
alias ta="tmux a"
alias tta="tmux a -t"

# ─────────────────────────────────────────
# Trash-cli
# ─────────────────────────────────────────
alias tr="trash-put -i"
alias trl="trash-list"
alias trm="trash-rm"
alias trs="trash-restore"

# ─────────────────────────────────────────
# Custom commands in .bash_profile
# ─────────────────────────────────────────
alias gc="grepcat"
alias gits="git global-status"

# ─────────────────────────────────────────
# Find directories by name (Arch equivalent)
# ─────────────────────────────────────────
alias f="sudo find / -type d -name"

# ─────────────────────────────────────────
# Mount media
# ─────────────────────────────────────────
alias mt="cd /run/media/$USER && ls"

# ─────────────────────────────────────────
# AppImages
# ─────────────────────────────────────────
#alias tor="cd ~/Downloads/XDM/General/tor-browser && ./start-tor-browser.desktop"
#alias wps="cd ~/AppImages && ./WPS-Office.AppImage &"

# ─────────────────────────────────────────
# Network Tools
# ─────────────────────────────────────────
alias pvpsh="nmcli connection show --active"
alias pvpd="nmcli connection delete"
alias nh="sudo nethogs"

# ─────────────────────────────────────────
# TOR service
# ─────────────────────────────────────────
alias tor="sys start tor"
alias stor="sys stop tor"
alias rtor="sys restart tor"
alias tost="sys status tor"

# ─────────────────────────────────────────
# Docker
# ─────────────────────────────────────────
alias ds="sudo systemctl start docker"
alias dst="sudo systemctl stop docker docker.socket"
alias dstat="sudo systemctl status docker"

alias dds="systemctl --user start docker-desktop"
alias ddst="systemctl --user stop docker-desktop"

alias alpine="docker start -i alpine"
alias mssql="docker start -i mssql"

alias dock="ds && dds"
alias dockd="dst && ddst"

# ─────────────────────────────────────────
# Podman
# ─────────────────────────────────────────
alias pds="sudo systemctl start podman"
alias pdst="sudo systemctl stop podman podman.socket"
alias pdstat="sudo systemctl status podman"
alias pdps="podman ps -a"

alias polla="podman start ollama"
alias polls="podman stop ollama"

alias polq0="podman exec -it ollama ollama run qwen2.5-Coder:0.5b"
alias polq1="podman exec -it ollama ollama run qwen2.5-Coder:1.5b"
alias polq3="podman exec -it ollama ollama run qwen2.5-Coder:3b"

# ─────────────────────────────────────────
# Loading script
# ─────────────────────────────────────────
#while true; do for var in / -\\ \|; do echo -en "\r$var"; sleep .1 done; done

# ─────────────────────────────────────────
# zsh autocorrect
# ─────────────────────────────────────────
setopt correct

# ─────────────────────────────────────────
# VSCode Permission Fix
# ─────────────────────────────────────────
alias vso="sudo chown -R $(whoami) /usr/share/vscodium"

# ─────────────────────────────────────────
# Source Reload
# ─────────────────────────────────────────
alias sr='
current_shell=$(ps -p $$ -o comm=)
if [[ "$current_shell" == "zsh" ]]; then
    exec zsh
else
    source ~/.bashrc
fi
'
