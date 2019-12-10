cp ~/.bash_profile .
cp ~/.zshrc .
cp ~/.vimrc .
cp -r ~/.vim .
cp -r ~/.config .

git add .
git commit -am $(date "+%Y-%m-%d_%H:%M:%S")
git push
