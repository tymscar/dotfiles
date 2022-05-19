export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="aditya"

plugins=(git)

source $ZSH/oh-my-zsh.sh

source /usr/share/nvm/init-nvm.sh

alias ls="lsd"
alias cat="bat"
path+=('/home/tymscar/.local/bin')
export PATH
