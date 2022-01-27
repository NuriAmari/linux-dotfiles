get_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="\[\033[38;5;245m\]\w\[\033[33m\]\$(get_git_branch) \[\e[0m\]"
export FZF_DEFAULT_COMMAND='rg --files'
export SCCACHE_CACHE_SIZE="30G"
export PATH=$PATH:/usr/lib/jvm/java-11-amazon-corretto/bin

alias pbcopy='xclip -selection clipboard'
alias dev-clang=/home/nuria/Git/llvm-project/build/bin/clang++
alias gdb-dev-clang="gdb --args /home/nuria/Git/llvm-project/build/bin/clang++"
alias dev-swiftc=/home/nuria/Git/swift-project/build/Ninja-RelWithDebInfoAssert/swift-linux-x86_64/bin/swiftc
