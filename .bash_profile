export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles

export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
alias ls="ls -GFh -a"

# alias vim=nvim

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

bing() {
	search=""
	for term in $@; do
		search="$search $term"
	done
	open "http://cn.bing.com/search?q="
}

neofetch

export SDKROOT="$(xcrun --show-sdk-path)"
# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# export PATH="$PATH:/usr/local/opt/llvm/bin"
# export PATH="/usr/local/opt/llvm/bin:$PATH"
C_INCLUDE_PATH=/usr/local/include/
export C_INCLUDE_PATH
CPLUS_INCLUDE_PATH=/usr/local/include/
export CPLUS_INCLUDE_PATH
export LIBRARY_PATH=/usr/local/lib/

debug(){
	mkdir build
	cd build
	cmake -DCMAKE_BUILD_TYPE=Debug ..
	make $@
	cd ..
}
release(){
	mkdir build
	cd build
	cmake -DCMAKE_BUILD_TYPE=Release ..
	make $@
	cd ..
}
