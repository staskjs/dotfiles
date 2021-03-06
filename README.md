# The problem

I regularly use multiple machines and ssh to several servers at work. And I use zsh all the time.
It is always a trouble to synchronize same zsh config and all other possible configs (like vim, tmux, etc) between all the machines.

So I created a set of command for myself to make this routine easier.

Feel free to fork and configure for your personal needs.

# Dotfiles

Repository currently includes `.zshrc` and `.tmux.conf`.

If you want to add custom zsh config for every machine, create file `~/.zshrc.custom`.

Same goes for tmux, use `~/.tmux.conf.custom` file to contain local config.

Vim settings can be found in separate repository [here](https://github.com/staskjs/vimsettings).
However, `.vim` is also managed by this setup.

Some good ideas are taken from [https://github.com/thoughtbot/dotfiles](https://github.com/thoughtbot/dotfiles).

# Installation

Run installation script. It can also be used to update dotfiles.
```sh
$ sh -c "$(wget https://raw.githubusercontent.com/staskjs/dotfiles/master/install.sh -O -)"
```

*NOTE*: you should have `zsh` and `git` to be installed.

# Usage

To update dotfiles use command:
```sh
$ dotup
```

To commit and push changes:
```sh
$ dotpush
```

I use [powerlevel9k oh-my-zsh theme](https://github.com/bhilburn/powerlevel9k) which requires powerline patched fonts to be installed and used.
In case of missing or not being able to install them on particular device, next command can be used to toggle into simpler theme.
```sh
$ dots
```
`dots` stands for `dot simple`

View dotfiles git status
```sh
$ dotst
```

To commit and push vim changes:
```sh
$ vimpush
```

View .vim git status
```sh
$ vimst
```
