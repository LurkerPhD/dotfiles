export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles

export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
alias ls="ls -GFh -a"

alias chrome="open -a 'Google Chrome.app'"
alias "cchrome"="osascript -e 'quit app \"Google Chrome.app\"' "

alias qq="open -a 'QQ'"
alias "cqq"="osascript -e 'quit app \"QQ.app\"' "

alias wps="open -a 'wpsoffice'"
alias "cwps"="osascript -e 'quit app \"wpsoffice.app\"' "

alias music="open -a 'Music.app'"
alias "cmusic"="osascript -e 'quit app \"Music.app\"' "

alias paraview="open -a 'paraview-5.6.0.app'"
alias "cparaview"="osascript -e 'quit app \"paraview-5.6.0.app\"' "

alias trash='open ~/.Trash'

alias vim=nvim

setopt NO_LIST_BEEP MENU_COMPLETE AUTO_MENU

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

google() {
    search=""
    for term in $@; do
        search="$search%20$term"
    done
    open "http://www.google.com/search?q=$search"
}

baidu() {
    search=""
    for term in $@; do
        search="$search $term"
    done
    open "http://www.baidu.com/s?wd=$search" }

neofetch
export SDKROOT="$(xcrun --show-sdk-path)"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
