export PS1="\[\033[38;5;11m\]\u@\h\[$(tput sgr0)\]\[\033[38;5;10m\]::\[$(tput sgr0)\]\[\033[38;5;6m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\] \\$ \[$(tput sgr0)\]"

export TERM="xterm-256color"
export DOTFILES="$HOME/.dotfiles"
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

if type tmux > /dev/null; then
  alias tmux="tmux -2"
fi

if type tmuxinator > /dev/null; then
  alias mux="tmuxinator"
  alias t="tmuxinator start"
fi

if type vim > /dev/null; then
  export EDITOR=vim
else
  export EDITOR=vi
fi

PATH=/opt/local/bin:$PATH

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

source ~/.bashrc.local
