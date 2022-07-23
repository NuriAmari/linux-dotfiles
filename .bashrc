get_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="\[\033[38;5;245m\]\w\[\033[33m\]\$(get_git_branch) \[\e[0m\]"
export FZF_DEFAULT_COMMAND='rg --files'
export SCCACHE_CACHE_SIZE="30G"
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
export PATH=$PATH:/home/nuria/install/syncthing/bin
export PATH=$PATH:/home/nuria/.yarn/bin
export EDITOR=$(which nvim)

alias pbcopy='xclip -selection clipboard'
alias dev-clang=/home/nuria/Git/llvm-project/build/bin/clang++
alias gdb-dev-clang="gdb --args /home/nuria/Git/llvm-project/build/bin/clang++"
alias dev-swiftc=/home/nuria/Git/swift-project/build/Ninja-RelWithDebInfoAssert/swift-linux-x86_64/bin/swiftc
alias vim=nvim
. "$HOME/.cargo/env"
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm


