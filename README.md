# The problem

I regularly use multiple machines and ssh to several servers at work. And I use zsh all the time.
It is always a trouble to synchronize same zsh config and all other possible configs (like vim, tmux, etc) between all the machines.

So I created a set of command for myself to make this routine easier.

# Dotfiles

Repository currently includes `.zshrc` and `.tmux.conf`.

If you want to add custom zsh config for every machine, create file `~/.zshrc.custom`.

Same goes for tmux, use `~/.tmux.conf.custom` file to contain local config.

Vim settings can be found in separate repository [here](https://github.com/staskjs/vimsettings).
However, `.vim` is also managed by this setup.

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
