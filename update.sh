cp ~/.bash_profile .
cp ~/.zshrc .
cp ~/.vimrc .
mkdir .vim
cp ~/.vim/coc-settings.json .vim/coc-settings.json
mkdir .config
cp -r ~/.config/alacritty .config/alacritty
cp -r ~/.config/coc/ultisnips .config/coc/ultisnips

git add .
git commit -am $(date "+%Y-%m-%d_%H:%M:%S")
git push
