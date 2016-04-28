# The problem

I regularly use multiple machines and ssh to several servers at work. And I use zsh all the time.
It is always a trouble to synchronize same zsh config and all other possible configs (like vim, tmux, etc) between all the machines.

So I created a set of command for myself to make this routine easier.

# Usage

Run installation script. It can also be used to update dotfiles.
```sh
sh -c "$(wget https://raw.githubusercontent.com/staskjs/dotfiles/master/install.sh -O -)"
```

To update dotfiles use command:
```sh
dotup
```

To commit and push changes:
```sh
dotpush
```

View dotfiles git status
```sh
dotst
```

To commit and push vim changes:
```sh
vimpush
```

View .vim git status
```sh
vimst
```
