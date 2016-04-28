# Use colors, but only if connected to a terminal, and that terminal
# supports them.
if type tput > /dev/null; then
    ncolors=$(tput colors)
fi
if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    YELLOW="$(tput setaf 3)"
    BLUE="$(tput setaf 4)"
    BOLD="$(tput bold)"
    NORMAL="$(tput sgr0)"
else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    BOLD=""
    NORMAL=""
fi

OMZ_INSTALLED=0
# Check if oh-my-zsh is installed. If not, then install it.
if [ ! -d ~/.oh-my-zsh ]; then
    echo "Installing oh my zsh"
    git clone -q https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    OMZ_INSTALLED=1
fi

# Install or update powerlevel9k zsh theme
if [ -d ~/.oh-my-zsh/custom/themes/powerlevel9k ]; then
    echo "Powerlevel9k is installed - updating"
    git -C ~/.oh-my-zsh/custom/themes/powerlevel9k pull > /dev/null
else
    echo "Powerlevel9k theme is not installed - installing"
    git clone -q https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
fi

# Clone or update dotfiles directory
export DOTFILES_DIR="$HOME/.dotfiles"
if [ ! -d "$DOTFILES_DIR" ]; then
    echo "Installing dotfiles in $DOTFILES_DIR"
    git clone -q https://github.com/staskjs/dotfiles.git $DOTFILES_DIR
else
    CHANGED=$(git -C $DOTFILES_DIR diff-index --name-only HEAD --)
    if [ -n "$CHANGED" ]; then
        echo "${RED}$DOTFILES_DIR has changed. Commit or discard them and try again.${NORMAL}"
        exit 1
    else
        echo "Updating dotfiles"
        git -C $DOTFILES_DIR pull > /dev/null
    fi
fi

# Copy .zshrc to home directory
echo "Installing .zshrc"
rm ~/.zshrc
cp $DOTFILES_DIR/zshrc ~/.zshrc

# Switch to zsh finally
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

echo "${GREEN}"
echo "Everything is installed successfully!"
if [ "$OMZ_INSTALLED" -eq 1 ]; then
    echo "Feel free to explore oh-my-zsh on https://github.com/robbyrussell/oh-my-zsh"
fi

echo "${BLUE}Use ~/.zshrc.custom file (create if not exists) to keep all custom configuration for current machine there."
echo "~/.zshrc should not contain any custom configuration, because it will be overriden on next update"

echo "${NORMAL}"

env zsh
