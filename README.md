# My Dotfiles

This repo is an experimental work in progress!!

These are my revised dotfiles and as such are a work in progress.

My operating system is Fedora Silverblue which is an atomic (immutable) operating system.

Apart from the Kitty terminal app, Flatpak is used to install any desktop apps I require.
Apart from my desktop apps, I use the stuff I require a run in containers.

My personal development environment is based on the Neovim text editor which I run in a toolbox container using 
distrobox to enter the container.


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



