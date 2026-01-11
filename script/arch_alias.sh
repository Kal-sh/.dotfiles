# ─────────────────────────────────────────
# Package Manager (CachyOS)
# ─────────────────────────────────────────

# ─────────────────────────────────────────
# Pacman
# ─────────────────────────────────────────
alias i="sudo pacman -S"
alias iy="sudo pacman -Sy"
alias rmi="sudo pacman -Rs"
alias cc="sudo pacman -Sc"
alias cln="sudo pacman -Rns $(pacman -Qdtq)"
alias clean="cln && cc"
alias installed="pacman -Qe"
alias repo="pacman -Ql"
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

# ─────────────────────────────────────────
# CachyOS pacman wrapper
# ─────────────────────────────────────────

# update file database
alias ref="sudo pacman -Fy"

# Get fastest mirrors
alias mirror="sudo cachyos-rate-mirrors"

# fix pacman after snapper restore
alias fixpacman="sudo rm /var/lib/pacman/db.lck"

# ─────────────────────────────────────────
# AUR helper (paru)
# ─────────────────────────────────────────
alias pi="paru -S"
alias piy="paru -Sy"
alias prm="paru -Rs"

# ─────────────────────────────────────────
# System / General
# ─────────────────────────────────────────
alias sys="sudo systemctl"
alias q="exit"
alias cl="clear"

# ─────────────────────────────────────────
# Toolbox / Distrobox
# ─────────────────────────────────────────
#alias tb="toolbox enter"
#alias tbl="toolbox list"
#alias tbc="toolbox create"
#alias tbs="podman container stop"
#alias tbr="toolbox rm -f"

alias dbe="distrobox enter"
alias dbl="distrobox list"
alias dbc="distrobox create"
alias dbs="distrobox stop"
alias drm="distrobox rm -f"

# ─────────────────────────────────────────
# CLI Tools
# ─────────────────────────────────────────
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
alias oc="opencode"
alias gm="gemini"

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
# User custom commands
# ─────────────────────────────────────────

# @ .gitconfig
alias gits="git global-status"

# @ .bash_profile
alias gc="grepcat"
alias fn="fd_dir"
alias fdn="fdn_dir"
alias ff="fd_file"
alias sp="searchpkg"
alias upd="update"

# ─────────────────────────────────────────
# Stolen from CachyOS fish config
# ─────────────────────────────────────────

# Replace ls with eza
alias ls='eza -a --color=always --group-directories-first --icons'  # preferred listing
alias ll='eza -al --color=always --group-directories-first --icons' # long format
alias lt='eza -aT --color=always --group-directories-first --icons' # tree listing
alias l.="eza -a | grep -e '^\.'"                                   # show only dotfiles

# Grub update
alias grubup="sudo grub-mkconfig -o /boot/grub/grub.cfg"

# Tar
alias tarnow='tar -acf '
alias untar='tar -zxvf '

alias wget='wget -c '

# Processes
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'

# Directory related
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

# Grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Hardware Info
alias hw='hwinfo --short'

# Sort installed packages according to size in MB
alias big="expac -H M '%m\t%n' | sort -h | nl"

# List amount of -git packages
alias gitpkg='pacman -Q | grep -i "\-git" | wc -l'

# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

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
#alias ds="sudo systemctl start docker"
#alias dst="sudo systemctl stop docker docker.socket"
#alias dstat="sudo systemctl status docker"

#alias dds="systemctl --user start docker-desktop"
#alias ddst="systemctl --user stop docker-desktop"

#alias alpine="docker start -i alpine"
#alias mssql="docker start -i mssql"

#alias dock="ds && dds"
#alias dockd="dst && ddst"

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
# VSCode change ownership
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
