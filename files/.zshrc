export ZSH=/home/docker/.oh-my-zsh

ZSH_THEME="fishy"

plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

bindkey -v

export LANG=en_US.UTF-8
export EDITOR='vim'

alias vimgo='vim -u ~/.vimrc.go'
alias vg='vim -u ~/.vimrc.go'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Find Go source code files excluding vendor folder
function gosrc() {
  find . -path ./vendor -prune -o -name '*.go'
}

# Find Go packages excluding vendor folder
function gopkg() {
  go list ./... | grep -v /vendor/
}
