if [ ! -d ~/.oh-my-zsh ]; then
    echo "Install oh my zsh"
    sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
    exit
fi

echo "Oh my zsh - success"
if [ -d ~/.oh-my-zsh/custom/themes/powerlevel9k ]; then
    echo "Powerlevel update"
    git -C ~/.oh-my-zsh/custom/themes/powerlevel9k pull
else
    echo "No powerlevel 9k theme is installed"
    git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
fi
echo "Powerlevel9k - success"


