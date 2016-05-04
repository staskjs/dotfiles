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

REPO_URL="https://github.com/staskjs/dotfiles.git"
VIM_REPO_URL="https://github.com/staskjs/vimsettings.git"

if [ ! -n "$DOTFILES_VIM"  ]; then
    DOTFILES_VIM=1
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

if [ ! -n "$DOTFILES"  ]; then
    export DOTFILES="$HOME/.dotfiles"
fi

# Clone or update dotfiles directory
if [ ! -d "$DOTFILES" ]; then
    echo "Installing dotfiles in $DOTFILES"
    git clone -q $REPO_URL $DOTFILES
else
    CHANGED=$(git -C $DOTFILES diff-index --name-only HEAD --)
    if [ -n "$CHANGED" ]; then
        echo "${RED}$DOTFILES has changes. Commit (use \`dotpush\` command) or discard them and try again.${NORMAL}"
        exit 1
    else
        echo "Updating dotfiles"
        git -C $DOTFILES pull > /dev/null
    fi
fi

if [ ! -n "$ZSH_CUSTOM"  ]; then
    ZSH_CUSTOM="$ZSH/custom"
fi

# Copy functions file to zsh_custom directory
if [ -f $ZSH_CUSTOM/functions.zsh ]; then
    rm $ZSH_CUSTOM/functions.zsh
fi
ln -s $DOTFILES/functions.zsh $ZSH_CUSTOM/functions.zsh

# ---------------------------------------------------
# Copy .zshrc to home directory
echo "Installing .zshrc"
if [ -f ~/.zshrc ]; then
    rm ~/.zshrc
fi
ln -s $DOTFILES/zshrc ~/.zshrc
# ---------------------------------------------------
# Copy .tmux.conf to home directory
echo "Installing .tmux.conf"
if [ -f ~/.tmux.conf ]; then
    rm ~/.tmux.conf
fi
ln -s $DOTFILES/tmux.conf ~/.tmux.conf
# ---------------------------------------------------
# Copy git config files to home directory
echo "Installing git config"
if [ -f ~/.gitconfig ]; then
    rm ~/.gitconfig
fi
ln -s $DOTFILES/gitconfig ~/.gitconfig

if [ -f ~/.gitmessage ]; then
    rm ~/.gitmessage
fi
ln -s $DOTFILES/gitmessage ~/.gitmessage

if [ -f ~/.gitignore ]; then
    rm ~/.gitignore
fi
ln -s $DOTFILES/gitignore ~/.gitignore
# ---------------------------------------------------
# Copy .tmux.conf to home directory
echo "Installing .irbrc"
if [ -f ~/.irbrc ]; then
    rm ~/.irbrc
fi
ln -s $DOTFILES/irbrc ~/.irbrc
# ---------------------------------------------------

# Install or update vim
if [ "$DOTFILES_VIM" -eq 1 ]; then
    if [ -d ~/.vim ]; then
        CHANGED=$(git -C ~/.vim diff-index --name-only HEAD --)
        if [ -n "$CHANGED" ]; then
            echo "${RED}~/.vim has changes. Commit (use \`vimpush\` command) or discard them and try again.${NORMAL}"
            exit 1
        else
            echo "Updating vim"
            git -C ~/.vim pull > /dev/null
        fi
    else
        echo "Installing vim settings"
        git clone -q $VIM_REPO_URL ~/.vim
    fi
    git -C ~/.vim submodule update --init --recursive

    # Copy vimrc file
    if [ -f ~/.vimrc ]; then
        rm ~/.vimrc
    fi
    ln -s ~/.vim/vimrc ~/.vimrc
fi

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
echo "~/.zshrc should not contain any custom configuration, because it will be overriden on next update."

echo "${NORMAL}"

env zsh
