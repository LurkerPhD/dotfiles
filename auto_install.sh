# hide dock
defaults write com.apple.dock autohide -bool true && killall Dock
defaults write com.apple.dock autohide-delay -float 1000 && killall Dock
defaults write com.apple.dock no-bouncing -bool TRUE && killall Dock

# Setup Hostname
sudo scutil --set HostName Lurker-macbook

# install Command Line
xcode-select --install

# Install Homebrew
if test ! $(which brew); then
  echo "Installing homebrew..."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Install softwares and fonts from Brewfile with brew bundle
brew bundle

if test ! $(which zsh); then
  # change default shell to zsh
  chsh -s $(which zsh)
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

# Setup .bash_profile .bashrc .zshrc
cp .bash_profile .vimrc .zshrc ~/

# Setup VSCode
sudo ln -s /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code ~/Applications/code

set -o nounset    # error when referencing undefined variable
set -o errexit    # exit when command fails

# Install latest nodejs
if [ ! -x "$(command -v node)" ]; then
    curl --fail -LSs https://install-node.now.sh/latest | sh
    export PATH="/usr/local/bin/:$PATH"
    # Or use apt-get
    # sudo apt-get install nodejs
fi

# Use package feature to install coc.nvim
# for vim8
# mkdir -p ~/.vim/pack/coc/start
# cd ~/.vim/pack/coc/start
# curl --fail -L https://github.com/neoclide/coc.nvim/archive/release.tar.gz|tar xzfv -
# for neovim
# mkdir -p ~/.local/share/nvim/site/pack/coc/start
# cd ~/.local/share/nvim/site/pack/coc/start
# curl --fail -L https://github.com/neoclide/coc.nvim/archive/release.tar.gz|tar xzfv -

# Install extensions
mkdir -p ~/.config/coc/extensions
cd ~/.config/coc/extensions
if [ ! -f package.json ]
then
  echo '{"dependencies":{}}'> package.json
fi
# Change extension names to the extensions you need
npm install coc-snippets --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod

