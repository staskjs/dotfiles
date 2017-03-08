export DOTFILES="$HOME/.dotfiles"

# ----------------------- PROMPT ----------------------

# Regular colors
txtblk="$(tput setaf 0 2>/dev/null || echo '\e[0;30m')"  # Black
txtred="$(tput setaf 1 2>/dev/null || echo '\e[0;31m')"  # Red
txtgrn="$(tput setaf 2 2>/dev/null || echo '\e[0;32m')"  # Green
txtylw="$(tput setaf 3 2>/dev/null || echo '\e[0;33m')"  # Yellow
txtblu="$(tput setaf 4 2>/dev/null || echo '\e[0;34m')"  # Blue
txtpur="$(tput setaf 5 2>/dev/null || echo '\e[0;35m')"  # Purple
txtcyn="$(tput setaf 6 2>/dev/null || echo '\e[0;36m')"  # Cyan
txtwht="$(tput setaf 7 2>/dev/null || echo '\e[0;37m')"  # White

# Reset color
txtrst="$(tput sgr 0 2>/dev/null || echo '\e[0m')"  # Text Reset

# Load Git functions
find_git_branch() {
  # Based on: http://stackoverflow.com/a/13003854/170413
  local branch
  if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
    if [[ "$branch" == "HEAD" ]]; then
      branch='detached*'
    fi
    git_branch="($branch) "
  else
    git_branch=""
  fi
}

find_git_dirty() {
  local status=$(git status --porcelain --untracked-files=no 2> /dev/null)
  if [[ "$status" != "" ]]; then
    gitcolor="$txtylw"
  else
    gitcolor="$txtgrn"
  fi
}

PROMPT_COMMAND="find_git_branch; find_git_dirty; $PROMPT_COMMAND"

export PS1="\[\033[38;5;11m\]\u@\h\[$(tput sgr0)\]\[\033[38;5;10m\]::\[$(tput sgr0)\]\[\033[38;5;6m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\] \$gitcolor\$git_branch\[$txtrst\]\\$ \[$(tput sgr0)\]"

# ----------------------- END PROMPT ----------------------

export TERM="xterm-256color"
export PATH="$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"

if [ -d $HOME/.rvm ]; then
  export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
  source $HOME/.rvm/scripts/rvm
fi

if [ -d $HOME/.composer ]; then
  export PATH="$PATH:$HOME/.composer/vendor/bin"
fi

if [ -d $HOME/dasht ]; then
  export PATH="$PATH:$HOME/dasht/bin"
fi

alias tmux="tmux -2"

alias mux="tmuxinator"
alias t="tmuxinator start"

if type vim > /dev/null; then
  export EDITOR=vim
else
  export EDITOR=vi
fi

PATH=/opt/local/bin:$PATH

# ----------------------- ALIASES ----------------------

# Git aliases
alias ga='git add'
alias gb='git branch'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gcam='git commit -a -m'
alias gcm='git checkout master'
alias gcd='git checkout develop'
alias gco='git checkout'
alias gcount='git shortlog -sn'
alias gd='git diff'
alias gl='git pull'
alias glg='git log --stat'
alias glgp='git log --stat -p'
alias gm='git merge'
alias gp='git push'
alias gst='git status'
alias grb='git rebase'

# Rails aliases
alias rc='rails console'
alias rd='rails destroy'
alias rg='rails generate'
alias rgm='rails generate migration'
alias rs='rails server'
alias rdm='rake db:migrate'
alias rdr='rake db:rollback'
alias rr='rake routes'

# Laravel aliases
alias la4='php artisan'
alias la5='php artisan'
alias la4m='php artisan migrate:make'
alias la5m='php artisan make:migration'

# ----------------------- END ALIASES ----------------------

if [ ! -d ~/.bashrc.local ]; then
  source ~/.bashrc.local
fi
