if [ ! -d ~/.oh-my-zsh ]; then
    echo "Install oh my zsh"
    echo "To do this please go to https://github.com/robbyrussell/oh-my-zsh"
    exit
fi

if [ -d ~/.oh-my-zsh/custom/themes/powerlevel9k ]; then
    echo "Powerlevel9k is installed - updating"
    git -C ~/.oh-my-zsh/custom/themes/powerlevel9k pull
else
    echo "Powerlevel9k theme is not installed - installing"
    git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
fi

DOTFILES_DIR="$HOME/df"
if [ ! -d "$DOTFILES_DIR" ]; then
    echo "Installing dotfiles"
    git clone https://github.com/staskjs/dotfiles.git $DOTFILES_DIR
else
    echo "Updating dotfiles"
    git -C $DOTFILES_DIR pull
fi

echo "Installing .zshrc"
rm ~/.zshrc
cp $DOTFILES_DIR/zshrc ~/.zshrc

TEST_CURRENT_SHELL=$(expr "$SHELL" : '.*/\(.*\)')
if [ "$TEST_CURRENT_SHELL" != "zsh" ]; then
    # If this platform provides a "chsh" command (not Cygwin), do it, man!
    if hash chsh >/dev/null 2>&1; then
      chsh -s $(grep /zsh$ /etc/shells | tail -1)
    # Else, suggest the user do so manually.
    else
      printf "I can't change your shell automatically because this system does not have chsh.\n"
      printf "Please manually change your default shell to zsh!\n"
    fi
fi
env zsh
