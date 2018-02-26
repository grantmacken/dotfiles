# dotfiles

Work In Progress [dotfiles](https://github.com/webpro/awesome-dotfiless) hacked by Grant Mackenzie

## Rationale

* Toolbox kept under git control ( my main _working_ desktop development environment )
* Repo can be downloaded and incorporated into a new os setup
* Used to organize main dotfiles [bashrc, nvim, etc]
  and other project tools used in my projects.

## How To

Project has a single `Makefile`

* `make help` will outline other make targets
* Make targets mostly uses _Stow_ to create symlinks from this repo to where ever they are required.

## How I have organized this stuff

After a brief search on how best to organize my dotfiles under git control, I set
upon using [stow](http://mywiki.wooledge.org/DotFiles) ]

This [github repo](https://github.com/grantmacken/dotfiles) is cloned into my projects
directory. In my projects directory have various folders named after
the `GIT REPO OWNER LOGIN` names.

So my dotfile repo is cloned into a folder under git handle in the projects dir

`~/projects/$(git config --get user.name)/dotfiles`

in the dotfiles project I have some folders,

```
- bash [ bashrc , [.config/bash/{configs}.sh ] ] ( prompt, alaises etc )
    => ~/
- bin: [ {EXECUTABLE} ]
    => ~/bin (my home bin )
- nvim: [ init.vim ] my nvim config
    => ~/.config/nvim/
- nvim/site: [ {runtimepath_folders} ]( my nvim local {runtimepath} )
    => ~/.local/share/nivim/site/
- projects: my git projects ~/projects/{GITUSER}
- projects/bin: [ bin/{EXECUTABLE} ]
    => ~/projects/{GITUSER}/
- projects/node: [ package.json , node-modules/.bin/{EXECUTABLE} ]
    => ~/projects/{GITUSER}/
 - projects/properties: [ project.properties , common.properties ]
    => ~/projects/{GITUSER}/
 - projects/make: [ Makefile, .tasks/ ]
    for each {web_project} as defined in common.properties
    => ~/projects/{GITUSER}/{web_project}/
```

### notes

* note: both ~/projects/{GITUSER}/bin and ~/projects/{GITUSER}/node_modules/.bin
  are on the shells $PATH, as set in bashrc
* note: npm install
* common.properties:  can-be-sourced key/value constant properties useful for any project
* project.properties: can-be-sourced bash expanded key/value project specific properties

and a Makefile in the root of the dir.

## WARNING

This is my working environment, and _NOT_ a skeleton setup.

If you are going stow bash,
you need to backup and remove your .bashrc
then modify the .bashrc in the in the bash dir to suit your requirements.

## Misc Set Up Tasks

Keyboard: set capslock to escape
neovim backspace fix

