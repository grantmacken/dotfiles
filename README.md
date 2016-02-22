# dotfiles

my dotfiles

After a brief search on how best to organize my dofiles under git control, I set
upon using [stow](http://mywiki.wooledge.org/DotFiles) ]

`apt-get install stow`

The dotfiles is a git controlled repo on github and cloned into my projects
directory. In my projects directory have various folders named after the ```GIT REPO OWNER LOGIN`` names.

 So my dotfile repo is cloned into a folder under my name in the projects dir

    ~/projects/$(git config --get user.name)/dotfiles

in dotfiles project I have some folders

* bash
* tmux
* nvim
* bin

and a Makefile in the root of the dir.

`make` calls stow to symlink the git controlled dotfiles into my home
dir. the expeption being the `stow  bin` call which contains my local scripts
under git control.

    build:
        @stow -v -t ~ bash
        @stow -v -t ~ tmux
        @stow -v -t ~ vim
        @stow -v -t ~/bin bin

### Dependencies

    apt-get install silversearcher-ag

##tmux

Contains my tmux.conf.
With tmux I use [tpm](https://github.com/tmux-plugins/tpm),
the tmux plugin manager. The tmux plugins are listed which are listed at the
end of my tmux.conf

tmux is opened full in a on startup script. When tmux starts I hit C-Space + r
This restores my tmux workspace. As long as I remember to C-Space + s before I
shutdown everything will be restored to where I last left it.  

##vim

I am a Vim newbe, so this is under flux. It contains my vim configuration files.

My vim editing sessions are always opened in tmux.
I use key binding to move between tmux panes and vim splits.

##bin 

contains some of my bash scripts

#Some notes: Setting the keyboard [capslock](http://www.economyofeffort.com/2014/08/11/beyond-ctrl-remap-make-that-caps-lock-key-useful) so it maps to control, then map control to escape

in `~/,profile` 
```bash
  setxkbmap -layout us -option ctrl:nocaps
  xcape -e 'Caps_Lock=Escape;Control_L=Escape;Control_R=Escape'
```

gnome-terminal https://github.com/anuragsoni/seoul256-gnome-terminal
http://unix.stackexchange.com/questions/81335/xubuntu-mouse-sensitivity-way-too-high


* http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html
* http://spin.atomicobject.com/2014/12/26/manage-dotfiles-gnu-stow/
* http://taihen.org/managing-dotfiles-with-gnu-stow/
* https://www.youtube.com/watch?v=zhdO46oqeRw
* https://github.com/gotbletu/shownotes/blob/master/stow.txt

#dotfiles

* https://medium.com/@webprolific/getting-started-with-dotfiles-43c3602fd789
* https://github.com/webpro/awesome-dotfiles

* http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
* http://www.drbunsen.org/the-text-triumvirate/
