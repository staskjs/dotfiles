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

if [ ! -n "$DOTFILES"  ]; then
    export DOTFILES="$HOME/.dotfiles"
fi

# Clone or update dotfiles directory
if [ ! -d "$DOTFILES" ]; then
    echo "Installing dotfiles in $DOTFILES"
    git clone -q $REPO_URL $DOTFILES
else
    rm -rf $DOTFILES
    echo "Updating dotfiles in $DOTFILES"
    git clone -q $REPO_URL $DOTFILES
fi

# ---------------------------------------------------
# Copy .bash_profile to home directory
echo "Installing .bash_profile"
if [ -f ~/.bash_profile ]; then
    rm ~/.bash_profile
fi
ln -s $DOTFILES/bash_profile ~/.bash_profile
# ---------------------------------------------------
# Copy .bashrc to home directory
echo "Installing .bashrc"
if [ -f ~/.bashrc ]; then
    rm ~/.bashrc
fi
ln -s $DOTFILES/bashrc ~/.bashrc
# ---------------------------------------------------
# Copy .inputrc to home directory
echo "Installing .inputrc"
if [ -f ~/.inputrc ]; then
    rm ~/.inputrc
fi
ln -s $DOTFILES/inputrc ~/.inputrc
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
echo "Installing w3m keymap"
if [ -f ~/.w3m/keymap ]; then
    rm ~/.w3m/keymap
fi
ln -s $DOTFILES/w3m-keymap ~/.w3m/keymap
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

            if [ ! -f ~/.vim/bundle/Vundle.vim ]; then
                git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
            fi
        fi
    else
        echo "Installing vim settings"
        git clone -q $VIM_REPO_URL ~/.vim
    fi

    # Copy vimrc file
    if [ -f ~/.vimrc ]; then
        rm ~/.vimrc
    fi
    ln -s ~/.vim/vimrc ~/.vimrc
fi

echo "${GREEN}"
echo "Everything is installed successfully!"
echo "${BLUE}Use ~/.bashrc.local file (create if not exists) to keep all custom configuration for current machine there."
echo "~/.bashrc should not contain any custom configuration, because it will be overriden on next update."

echo "${NORMAL}"
