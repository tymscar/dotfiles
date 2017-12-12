# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

function feh() {
	open -b "drabweb.macfeh" "$@"
}

(wal -r &)

alias tymscar="ssh root@tymscar.com"
alias povestime="ssh root@povesti.me"
alias vim="nvim"
alias ls="exa"
