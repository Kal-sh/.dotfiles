#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

grepcat() {
  cat "$1" | grep "$2"
}


