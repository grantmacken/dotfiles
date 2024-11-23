# My Dotfiles

This repo is an experimental work in progress!!

My operating system is Fedora Silverblue which is an atomic (immutable) operating system, so my
aim is to provide a CLI customized toolbox work environment orientated around Neovim and associated CLI tooling

## First Things First
Clone this repo.
The bin dir contains a tbx-setup 

```

```



Keyboard: change caps lock into escape

```
dconf write /org/gnome/desktop/input-sources/xkb-options "['caps:escape']"

```

Install Make

```
rpm-ostree install make
```

## After Make is Installed


## After customised Toolbx is Installed

Ctl-Alt-T as a custom shortcut to open  ptyxis terminal

Open directly into Neovim with a ptyxis terminal default profile setting


## Configuration Dotfiles:





These are my revised dotfiles and as such are a work in progress.



My desktop apps are installed as flatpaks via flathub.

My personal development environment based on the Neovim text editor 
and other terminal CLI programs I use are installed in in a toolbox container.

## BASHRC

  - [x] mod in /bashrc - don't use systemd pager
  - [x] toolbox.sh: ensure we can enter the toolbox


### Install Terminal App From Source

  - kitty

## Create the toolbox quadlet to run Neovim with most of the tooling I require

When I open the kitty terminal, it enters into a [toolbox container](https://github.com/grantmacken/zie-toolbox)
 instance via distrobox. The instance opens the Neovim text editor and the toolbox provide most of the cli tooling I require.
However as a rule of thumb I try to excluded from the toolbox language runtimes and the tooling for these runtimes

### Edit XDG config files cli tools
   - gh
   - git
   - neovim
   - etc

 ### Automate language tooling updates via **image** *quadlets* and systemd *timers*

Build compile and test tooling for a language are contained in container image for that language.

TODO!



<!-- The systemd timer for the associated 'language server' ensures the *latest* language server is available. -->



