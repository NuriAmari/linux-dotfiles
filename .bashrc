# neovim alias
alias vim=$(which nvim)
alias vi=$(which nvim)
alias python="python3"

# remap caps to escape
setxkbmap -option caps:escape

# node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# default browser
export BROWSER=/usr/bin/google-chrome-stable

get_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="\[\033[38;5;245m\]\w\[\033[33m\]\$(get_git_branch) \[\e[0m\]"
