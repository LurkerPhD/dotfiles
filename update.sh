mv ~/.bash_profile .
mv ~/.zshrc .
mv ~/.vimrc .

git add .
git commit -am $(date "+%Y-%m-%d_%H:%M:%S")
git push
