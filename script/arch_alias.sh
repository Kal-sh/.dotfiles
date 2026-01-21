# ─────────────────────────────────────────
# PACKAGE MANAGEMENT
# ─────────────────────────────────────────

# Pacman
alias i="sudo pacman -S"
alias iy="sudo pacman -Sy"
alias rmi="sudo pacman -Rs"
alias cc="sudo pacman -Sc"
alias cln="sudo pacman -Rns $(pacman -Qdtq)"
alias clean="cln && cc"
alias installed="pacman -Qe"
alias repo="pacman -Ql"
alias ref="sudo pacman -Fy"

# CachyOS
alias mirror="sudo cachyos-rate-mirrors"
alias fixpacman="sudo rm /var/lib/pacman/db.lck"

# AUR Helper (paru)
alias pi="paru -S"
alias piy="paru -Sy"
alias prm="paru -Rs"

# Package Queries
alias big="expac -H M '%m\t%n' | sort -h | nl"
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

# ─────────────────────────────────────────
# SYSTEM & SERVICES
# ─────────────────────────────────────────

# Systemctl
alias sys="sudo systemctl"

# TOR
alias tor="sys start tor"
alias stor="sys stop tor"
alias rtor="sys restart tor"
alias tost="sys status tor"

# Podman Service
alias pdstat="sys status podman"
alias pds="sys start podman"
alias pdst="sys stop podman podman.socket"

# Hardware & System Info
alias hw='hwinfo --short'
alias jctl="journalctl -p 3 -xb"
alias grubup="sudo grub-mkconfig -o /boot/grub/grub.cfg"

# ─────────────────────────────────────────
# CONTAINERS
# ─────────────────────────────────────────

# Distrobox
alias dbc="distrobox create"
alias dbe="distrobox enter"
alias dbl="distrobox list"
alias dbs="distrobox stop"
alias drm="distrobox rm -f"

# Podman Containers
alias pdps="podman ps -a"
alias polla="podman start ollama"
alias polls="podman stop ollama"

alias polq0="podman exec -it ollama ollama run qwen2.5-Coder:0.5b"
alias polq1="podman exec -it ollama ollama run qwen2.5-Coder:1.5b"
alias polq3="podman exec -it ollama ollama run qwen2.5-Coder:3b"

# Docker Containers
#alias ds="sys start docker"
#alias dst="sys stop docker docker.socket"
#alias dstat="sys status docker"
#alias dds="sys --user start docker-desktop"
#alias ddst="sys --user stop docker-desktop"
#alias alpine="docker start -i alpine"
#alias mssql="docker start -i mssql"
#alias dock="ds && dds"
#alias dockd="dst && ddst"

# ─────────────────────────────────────────
# FILE & NAVIGATION
# ─────────────────────────────────────────

# File Listing (eza)
alias ls='eza -a --color=always --group-directories-first --icons'
alias ll='eza -al --color=always --group-directories-first --icons'
alias lt='eza -aT --color=always --group-directories-first --icons'
alias l.="eza -a | grep -e '^\.'"
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias mt="cd /run/media/$USER && ls"

# Directory Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

# Archives
alias tarnow='tar -acf'
alias untar='tar -zxvf'

# ─────────────────────────────────────────
# DEVELOPMENT
# ─────────────────────────────────────────

# Editors
alias e="vim"
alias n="nvim"

# Tmux
alias t="tmux"
alias tl="tmux ls"
alias ta="tmux a"
alias tta="tmux a -t"

# ─────────────────────────────────────────
# CLI UTILITIES
# ─────────────────────────────────────────

# System Monitors & Tools
alias bp="bpytop"
alias nc="ncdu"
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'

# Network Tools
alias pvpsh="nmcli connection show --active"
alias pvpd="nmcli connection delete"
alias nh="sudo nethogs"
alias wget='wget -c '
alias st="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -"

# Help & Quick Access
alias td="tldr"
alias xd="xdg-open"
alias oc="opencode"
alias gm="gemini"

# Trash cli
alias tr="trash-put -i"
alias trl="trash-list"
alias trm="trash-rm"
alias trs="trash-restore"

# Git
alias g="git"
alias gs="git status"
alias gss="git status -s"
alias ga="git add -A"
alias gc="git commit -m"
alias gp="git push"
alias gpl="git pull"
alias gco="git checkout"
alias gcb="git checkout -b"
alias gl="git log --oneline -10"
alias gd="git diff"

# ─────────────────────────────────────────
# Custom Functions
# ─────────────────────────────────────────

# .gitconfig
alias gits="git global-status"

# .bash_profile
alias gr="grepcat"
alias jr="jctl_err"
alias jf="jctl_live"
alias fn="fd_dir"
alias fdn="fdn_dir"
alias ff="fd_file"
alias sp="searchpkg"
alias upd="update"

# ─────────────────────────────────────────
# SHELL & APPLICATIONS
# ─────────────────────────────────────────

# Vscodium ownership
alias vso="sudo chown -R $(whoami) /usr/share/vscodium"

# AppImages
#alias tor="cd ~/Downloads/XDM/General/tor-browser && ./start-tor-browser.desktop"
#alias wps="cd ~/AppImages && ./WPS-Office.AppImage &"

# zsh autocorrect
setopt correct

# Shell
alias q="exit"
alias cl="clear"

# Source reload
alias sr='
current_shell=$(ps -p $$ -o comm=)
if [[ "$current_shell" == "zsh" ]]; then
    exec zsh
else
    exec bash
fi
'
