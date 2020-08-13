cp ~/.bash_profile .
cp ~/.zshrc .
cp ~/.vim .
mkdir .config
cp -r ~/.config/alacritty .config/
cp -r ~/.config/coc/ultisnips .config/coc/

git add .
git commit -am $(date "+%Y-%m-%d_%H:%M:%S")
git push
