if [ ! -d ~/.oh-my-zsh ]; then
    echo "Installing oh my zsh"
    git clone -q https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
fi

if [ -d ~/.oh-my-zsh/custom/themes/powerlevel9k ]; then
    echo "Powerlevel9k is installed - updating"
    git -C ~/.oh-my-zsh/custom/themes/powerlevel9k pull > /dev/null
else
    echo "Powerlevel9k theme is not installed - installing"
    git clone -q https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
fi

export DOTFILES_DIR="$HOME/.dotfiles"
if [ ! -d "$DOTFILES_DIR" ]; then
    echo "Installing dotfiles in $DOTFILES_DIR"
    git clone -q https://github.com/staskjs/dotfiles.git $DOTFILES_DIR
else
    CHANGED=$(git -C $DOTFILES_DIR diff-index --name-only HEAD --)
    if [ -n "$CHANGED" ]; then
        echo "$DOTFILES_DIR has changed. Commit or discard them and try again."
        exit 1
    else
        echo "Updating dotfiles"
        git -C $DOTFILES_DIR pull > /dev/null
    fi
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
