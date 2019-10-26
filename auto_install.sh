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
