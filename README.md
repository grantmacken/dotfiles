# dotfilesi
Work In Progress [dotfiles](https://github.com/webpro/awesome-dotfiless) hacked by Grant Mackenzie

Rationale: My current working desktop environment, that can be downloaded to set up a new setup. 

After a brief search on how best to organize my dofiles under git control, I set
upon using [stow](http://mywiki.wooledge.org/DotFiles) ]

The dotfiles is a git controlled repo on [github](https://github.com/grantmacken/dotfiles) and cloned into my projects
directory. In my projects directory have various folders named after the ```GIT REPO OWNER LOGIN`` names.

 So my dotfile repo is cloned into a folder under my name in the projects dir

   `~/projects/$(git config --get user.name)/dotfiles `

in the dotfiles project I have some folders

## bash ##
my bashrc and bashrc source files ( prompt, alaises etc )

- nvim: [ init.vim ] my nvim config
   * => ~/.config/nvim
- nvim/site: [ {runtimepath_folders}   ]
    * => ~/.local/share/nivim/site  ( my nvim local {runtimepath} )

    plugged: vim-plug placed plugins
            however for some pluggins it is possible to extend a plugin
            .e.g after ale is plugged by vim-plug
            my own {linter} created in
            `plugged/ale/ale_linters/{linter}`
             can be stowed into ale
            TODO:

- bin: [ {EXECUTABLE} ] 

   - => ~/bin (my home bin )
- projects: my git projects ~/projects/{GITUSER}
- projects/bin:  [ bin/{EXECUTABLE} ]
    => ~/projects/{GITUSER}/
- projects/node: [ package.json , node-modules/.bin/{EXECUTABLE} ]
    => ~/projects/{GITUSER}/
    note: both  ~/projects/{GITUSER}/bin and ~/projects/{GITUSER}/node_modules/.bin
    are on the shells $PATH, as set in bashrc
    note: npm install
 - projects/properties: [ project.properties , common.properties ]
    => ~/projects/{GITUSER}/
    common.properties: can-be-sourced key/value constant properties usefull for any project
    project.properties: can-be-sourced bash expanded key/value project specific properties
 - projects/make: [ Makefile, .tasks/ ]
    for each {web_project} as defined in common.properties
    => ~/projects/{GITUSER}/{web_project}/

and a Makefile in the root of the dir.

`make` calls stow to symlink the git controlled dotfiles into my home
dir.

```
    stow-all:
        @stow -v -t ~ bash
        @$(MAKE) stow-neovim
        @stow -v -t ~/bin bin
        @stow -v -t ~ tmux
```

#WARNING

If you are going stow bash, 
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

# NEOVIM 

- use XDG dirs
- use plugin manager vim-plug
- set up local pyEnv for neovim deoplete
- stow nvim config
structure
 + nvim
    [ init.vim ]   => XDG config ~/.config/nvim
   - site contents => XDG data  ~/.local/share/nivim/site
   - site/autoload ( plug.vim ) + [ autoloaded user defined vim files ]

notes:
https://dmerej.info/blog/post/vim-cwd-and-neovim/


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

TODO! WIP:  rm tmux 
Tmux
 - Sessions
 - Plugins
 

 Bin
  -- Solus App Install List



```
eopkg help
sudo  eopkg ur
sudo  eopkg up
make solus-packages
  ```
  
