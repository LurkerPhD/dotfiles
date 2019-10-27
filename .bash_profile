export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles

export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
alias ls="ls -GFh -a"

alias chrome="open -a 'Google Chrome'"
alias "cchrome"="osascript -e 'quit app \"Google Chrome\"' "

alias qq="open -a 'QQ'"
alias "cqq"="osascript -e 'quit app \"QQ\"' "

alias wps="open -a 'wpsoffice'"
alias "cwps"="osascript -e 'quit app \"wpsoffice\"' "

alias music="open -a 'NeteaseMusic'"
alias "cmusic"="osascript -e 'quit app \"NeteaseMusic\"' "

alias paraview="open -a 'ParaView-5.6.0.app'"
alias "cparaview"="osascript -e 'quit app \"ParaView-5.6.0.app\"' "

alias trash='open ~/.Trash'

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
