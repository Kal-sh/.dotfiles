# System
alias check="sudo dnf check-update"
alias update="sudo dnf update"
alias i="sudo dnf install"
alias rmi="sudo dnf remove"
alias ref="sudo dnf makecache --refresh"
alias sys="systemctl"
alias q="exit"
alias cl="clear"

# OS-Tree
alias ot="rpm-ostree"
alias ots="ot status"
alias oti="ot install"

# Toolbox
alias tb="toolbox enter"
alias tbl="toolbox list"
alias tbc="toolbox create"
alias tbs="podman container stop"
alias tbr="toolbox rm -f"

# Distrobox
alias dbe="distrobox enter"
alias dbl="distrobox list"
alias dbc="distrobox create"
alias dbs="distrobox stop"
alias drm="distrobox rm -f"

# cli tools
alias ls="lsd -A"
alias lsa="lsd -lA"
alias bp="bpytop"
alias td="tldr"
alias st="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -"
alias fk="fuck"

# Tmux
alias t="tmux"
alias tl="tmux ls"
alias ta="tmux a"
alias tta="tmux a -t"
alias n="nvim"

# Clean
alias cc="sudo dnf clean all"
alias cln="sudo dnf autoremove"
alias clean="cln && cc"
alias rip="remove-retired-packages"

# File related
alias nc="ncdu"
alias xd="xdg-open"
alias e="vi"
alias lol="lolcat"
alias f="sudo find / -type d -name"
alias installed="sudo dnf list installed"
alias repo="dnf repoquery --list"
alias mt="cd /run/media/kal && ls"

# AppImages
alias tor="cd /home/kal/Downloads/XDM/General/tor-browser-linux64-12.0.7_ALL/tor-browser && ./start-tor-browser.desktop"
alias qb="cd ~/Applications && ./qBittorrent-Enhanced-Edition.AppImage"
alias brave="cd ~/Applications && ./Brave-stable-v1.52.126-x86_64.AppImage"
alias onlyoffice="cd ~/Applications && ./OnlyOffice.AppImage"
alias rss="cd ~/Applications && ./Fluent_Reader.AppImage"
alias gpt="cd ~/AppImages && ./chat-gpt_1.1.0_amd64.AppImage &"
alias nt="cd ~/AppImages && ./Notion-2.3.2-1-x86-64.AppImage &"
alias wps="cd ~/AppImages && ./WPS-Office_11.1.0.11719-x86_64.AppImage &"

# Trash-cli

alias tr="trash-put -i"
alias trl="trash-list"
alias trm="trash-rm"
alias trs="trash-restore"

# Network
alias pvpsh="nmcli connection show --active"
alias pvpd="nmcli connection delete"
alias nh="sudo nethogs"

# tor
alias tor="sys start tor"
alias stor="sys stop tor"
alias rtor="sys restart tor"
alias tost="sys status tor"

# Docker
alias ds="systemctl start docker"
alias dst="systemctl stop docker docker.socket"
alias dstat="systemctl status docker"
alias dds="systemctl --user start docker-desktop"
alias ddst="systemctl --user stop docker-desktop"
alias alpine="docker start -i alpine"
alias mssql="docker start -i mssql"
alias dock="ds && dds"
alias dockd="dst && ddst"

# Podman
alias pds="systemctl start podman"
alias pdst="systemctl stop podman podman.socket"
alias pdstat="systemctl status podman"
alias pdps="podman ps -a"
alias polla="podman start ollama"
alias polls="podman stop ollama"
alias polq0="podman exec -it ollama ollama run qwen2.5-Coder:0.5b"
alias polq1="podman exec -it ollama ollama run qwen2.5-Coder:1.5b"
alias polq3="podman exec -it ollama ollama run qwen2.5-Coder:3b"
alias psodoo="sudo podman pod stop odoo-pod && sudo ss -tuln | grep 8069 && sudo ss -tuln | grep 5433"

# VScode ownership
#alias vso="sudo chown -R $(whoami) $(which code)"
#"$(which code)"
alias vso="sudo chown -R $(whoami) /usr/share/code"


# Source Update
alias sr='
#!/bin/bash

# Get the name of the current shell
current_shell=$(ps -p $$ -o comm=)

# Check if the current shell is zsh
if [[ "$current_shell" == "zsh" ]]; then
    exec zsh
else
    source ~/.bashrc
fi
'
