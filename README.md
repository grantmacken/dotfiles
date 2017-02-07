# dotfilesi
Work In Progress [dotfiles](https://github.com/webpro/awesome-dotfiless) hacked by Grant Mackenzie

After a brief search on how best to organize my dofiles under git control, I set
upon using [stow](http://mywiki.wooledge.org/DotFiles) ]

The dotfiles is a git controlled repo on [github](https://github.com/grantmacken/dotfiles) and cloned into my projects
directory. In my projects directory have various folders named after the ```GIT REPO OWNER LOGIN`` names.

 So my dotfile repo is cloned into a folder under my name in the projects dir

   ``` ~/projects/$(git config --get user.name)/dotfiles ```

in the dotfiles project I have some folders

- bash : my bashrc and bashrc source files ( prompt, alaises etc )
- nvim : my nvim config
- bin  : my bash helper scripts

and a Makefile in the root of the dir.

`make` calls stow to symlink the git controlled dotfiles into my home
dir.

```
    stow-all:
        @stow -v -t ~ bash
        @stow -v -t ~/.config/nvim nvim
        @stow -v -t ~/bin bin
        @stow -v -t ~ tmux

```

#WARNING

If you are going use this, 
you need to backup and remove your .bashrc
then modify the .bashrc in the in the bash dir to suit your requirements. 


##Some Set Up Tasks

Keyboard: set capslock to escape
          neovim backspace fix

TODO! : automate - fetch from git - make - setup service

```
make caps2sec
make neovimBackspaceFix
```

Neovim 

- use XDG dirs
- use plugin manager vim-plug
- set up local pyEnv for neovim deoplete
- stow nvim config

```
make pyEnv
make stow-neovim
```

Neovim Configuration Hilights
 TODO!

Terminal

- nice colors: seoul256-gnome-terminal
- a tidy bashrc with config scripts in XDG dir configuring prompt exports etc
   - an minimal prompt
   - $HOME script enviroments
     - python: pyEnv
     - perl TODO!


Tmux
 - Sessions
 - Plugins
 
