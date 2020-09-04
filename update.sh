cp ~/.bash_profile .
cp ~/.zshrc .
cp -r ~/.vim .
mkdir .config
sudo cp -r ~/.config/alacritty .config/
sudo cp -r ~/.config/coc/ultisnips .config/coc/

git add .
git commit -am $(date "+%Y-%m-%d_%H:%M:%S")
git push
