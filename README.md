# My Dotfiles

This repo is an experimental work in progress!!

My operating system is Fedora Silverblue which is an atomic (immutable) operating system, so my
aim is to provide a CLI customized toolbox work environment orientated around Neovim and associated CLI tooling

## Requirements

A modern linux OS with the following install CLI apps
1. podman
2. toolbox
3. dconf

Note: These are preinstalled on Fedora

## First Things First
Clone this repo and cd into it.
The bin dir contains a bash script: 'neovim-toolbox-setup'
Read the script before you run it!!!

```sh
# read the setup script
cat bin/neovim-toolbox-setup
# make sure it is executable
chmod +x bin/neovim-toolbox-setup
# run the script
./bin/neovim-toolbox-setup
```

<!-- The systemd timer for the associated 'language server' ensures the *latest* language server is available. -->



