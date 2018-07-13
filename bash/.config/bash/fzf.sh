#!/bin/bash


FZF_HOME="$HOME/.fzf"
[ -f $FZF_HOME ] && source $FZF_HOME

if [[ ! "$PATH" == *$FZF_HOME/bin* ]]; then
  export PATH="$PATH:$FZF_HOME/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source ${FZF_HOME}/shell/completion.bash 2> /dev/null

# Key bindings
# ------------
source ${FZF_HOME}/shell/key-bindings.bash

# https://medium.com/@crashybang/supercharge-vim-with-fzf-and-ripgrep-d4661fc853d2
# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder
# export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
export FZF_DEFAULT_COMMAND='rg --files --vimgrep --no-messages --no-ignore --hidden --follow --glob "!{.git,node_modules}/*"'
# FZF_DEFAULT_OPTS=''
# export FZF_DEFAULT_COMMAND=''

export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
# --select-1 automatically selects the item if there's only one so that you don't have to press enter key. Likewise, --exit-0 automatically exits when the list is empty. These options are also useful in
# export FZF_CTRL_T_OPTS='--select-1 --exit-0'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# bind -x '"\C-p": nvim $(fzf);'

    # Ctrl + r - search through bash history with fzf
    # Ctrl + p - edit a file in vim from fzf
    # mv dir/** - expand a directory with (**) and select from fzf
    # Alt + c - change directory from fzf - see the update at the bottom for faster search with bfs.
    # Ctrl + t - insert file from fzf into command

