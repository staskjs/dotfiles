function dotup() {
  env ZSH=$ZSH /bin/sh $DOTFILES/update.sh
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
