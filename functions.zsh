function dotup() {
  env ZSH=$ZSH /bin/sh $DOTFILES/install.sh
}

function dotpush() {
  CHANGED=$(git -C $DOTFILES diff-index --name-only HEAD --)
  if [ -n "$CHANGED" ]; then
      echo "Enter commit message: "
      read MESSAGE
      git -C $DOTFILES commit -am "$MESSAGE"
      git -C $DOTFILES push origin master
  else
      git -C $DOTFILES commit
  fi
}

function dotst() {
  git -C $DOTFILES status
}

function vimup() {
  env ZSH=$ZSH /bin/sh /.vim/install.sh
}

function vimpush() {
  CHANGED=$(git -C /.vim diff-index --name-only HEAD --)
  if [ -n "$CHANGED" ]; then
      echo "Enter commit message: "
      read MESSAGE
      git -C /.vim commit -am "$MESSAGE"
      git -C /.vim push origin master
  else
      git -C /.vim commit
  fi
}

function vimst() {
  git -C ~/.vim status
}
