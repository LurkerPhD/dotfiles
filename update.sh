cp ~/.bash_profile .
cp ~/.zshrc .
cp ~/.vimrc .

git add .
git commit -am $(date "+%Y-%m-%d_%H:%M:%S")
git push
