########## System Package Management (APT) ##########
alias check="sudo apt update"
alias update="sudo apt upgrade -y"
alias i="sudo apt install -y"
alias ref="sudo apt update --fix-missing"
alias sys="systemctl"
alias x="exit"
alias cl="clear"


########## Distrobox ##########
alias dbe="distrobox enter"
alias dbl="distrobox list"
alias dbc="distrobox create"
alias dbs="distrobox stop"
alias drm="distrobox rm -f"


########## CLI Tools ##########
alias lsa="eza -1"
alias bp="bpytop"
alias td="tldr"
alias st="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -"
alias fk="fuck"


########## Tmux ##########
alias t="tmux"
alias tl="tmux ls"
alias ta="tmux a"
alias tta="tmux a -t"


########## Cleaning ##########
alias cc="sudo apt clean"
alias cln="sudo apt autoremove -y"
alias clean="cln && cc"


########## File Related ##########
alias nc="ncdu"
alias xd="xdg-open"
alias e="vi"
alias lol="lolcat"
alias f="sudo find / -type d -name"
alias installed="apt list --installed"
alias repo="apt-cache show"
alias mt="cd /media/$USER && ls"


########## AppImages ##########
alias tor="cd ~/Downloads/XDM/General/tor-browser-linux64*/tor-browser && ./start-tor-browser.desktop"
alias qb="cd ~/Applications && ./qBittorrent-Enhanced-Edition.AppImage"
alias brave="cd ~/Applications && ./Brave*.AppImage"
alias onlyoffice="cd ~/Applications && ./OnlyOffice.AppImage"
alias rss="cd ~/Applications && ./Fluent_Reader.AppImage"
alias gpt="cd ~/AppImages && ./chat-gpt*.AppImage &"
alias nt="cd ~/AppImages && ./Notion*.AppImage &"
alias wps="cd ~/AppImages && ./WPS-Office*.AppImage &"


########## Trash-cli ##########
alias tr="trash-put -i"
alias trl="trash-list"
alias trm="trash-rm"
alias trs="trash-restore"


########## Network ##########
alias pvpsh="nmcli connection show --active"
alias pvpd="nmcli connection delete"
alias nh="sudo nethogs"
alias tor="sys start tor"
alias stor="sys stop tor"


########## Docker (Ubuntu) ##########
alias ds="sudo systemctl start docker"
alias dst="sudo systemctl stop docker docker.socket"
alias dstat="systemctl status docker"
alias dds="systemctl --user start docker-desktop"
alias ddst="systemctl --user stop docker-desktop"
alias alpine="docker start -i alpine"
alias mssql="docker start -i mssql"
alias dock="ds && dds"
alias dockd="dst && ddst"


########## Podman ##########
alias pds="sudo systemctl start podman"
alias pdst="sudo systemctl stop podman podman.socket"
alias pdstat="systemctl status podman"
alias pdps="podman ps -a"
alias polla="podman start ollama"
alias polls="podman stop ollama"
alias polq0="podman exec -it ollama ollama run qwen2.5-Coder:0.5b"
alias polq1="podman exec -it ollama ollama run qwen2.5-Coder:1.5b"
alias podoo="sudo podman pod start odoo-pod"
alias psodoo="sudo podman pod stop odoo-pod && sudo ss -tuln | grep 8069 && sudo ss -tuln | grep 5433"


########## VS Code Ownership ##########
alias vso="sudo chown -R $(whoami) /usr/share/code"


########## Source Update (Shell Reload) ##########
alias sr='
#!/bin/bash

current_shell=$(ps -p $$ -o comm=)

if [[ "$current_shell" == "zsh" ]]; then
    exec zsh
else
    source ~/.bashrc
fi
'

