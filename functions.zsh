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

function dots() {
  if [ "$DOTFILES_SIMPLE_THEME" -eq 1 ]; then
    export DOTFILES_SIMPLE_THEME=0
  else
    export DOTFILES_SIMPLE_THEME=1
  fi
  env zsh
}

function vimpush() {
  CHANGED=$(git -C ~/.vim diff-index --name-only HEAD --)
  if [ -n "$CHANGED" ]; then
      echo "Enter commit message: "
      read MESSAGE
      git -C ~/.vim commit -am "$MESSAGE"
      git -C ~/.vim push origin master
  else
      git -C ~/.vim commit
  fi
}

function vimst() {
  git -C ~/.vim status
}

function unpack() {
  if [ -f $1 ] ; then
  case $1 in
   *.tar.bz2)   tar xjf $1        ;;
   *.tar.gz)    tar xzf $1     ;;
   *.bz2)       bunzip2 $1       ;;
   *.rar)       unrar x $1     ;;
   *.gz)        gunzip $1     ;;
   *.tar)       tar xf $1        ;;
   *.tbz2)      tar xjf $1      ;;
   *.tgz)       tar xzf $1       ;;
   *.zip)       unzip $1     ;;
   *.Z)         uncompress $1  ;;
   *.7z)        7z x $1    ;;
   *)           echo "$fg_bold[red]Error:$reset_color unable to unpack file '$1'..." ;;
  esac
  else
  echo "$fg_bold[red]Error:$reset_color '$1' - unsupported file type"
  fi
}

function pack() {
  if [ $1 ] ; then
  case $1 in
   tbz)    tar cjvf $2.tar.bz2 $2      ;;
   tgz)    tar czvf $2.tar.gz  $2    ;;
   tar)   tar cpvf $2.tar  $2       ;;
   bz2) bzip $2 ;;
   gz)  gzip -c -9 -n $2 > $2.gz ;;
   zip)    zip -r $2.zip $2   ;;
   7z)     7z a $2.7z $2    ;;
   *)      echo "$fg_bold[red]Error:$reset_color '$1' cannot be packed with pack()" ;;
  esac
  else
  echo "$fg_bold[red]Error:$reset_color '$1' - unsupported file type"
  fi
}
