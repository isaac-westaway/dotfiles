#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
alias idf='. /home/isaacwestaway/build_files/esp/esp-idf/export.sh'

alias cd_c_cpp='cd ~/Documents/C_CPP\ Projects/'
alias web='firefox-developer-edition'
alias cargo='$HOME/.cargo/bin/cargo'

alias codedot='code . && exit'

. "$HOME/.cargo/env"

[ -f "/home/isaacwestaway/.ghcup/env" ] && . "/home/isaacwestaway/.ghcup/env" # ghcup-env
PATH=~/.console-ninja/.bin:$PATH
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pnpm
export PNPM_HOME="/home/isaacwestaway/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
alias OSX=~/OSX-KVM/OpenCore-Boot.sh
