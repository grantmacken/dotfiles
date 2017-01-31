#!/bin/bash

PROJECTS="$HOME/projects/$(git config user.name)"

alias vim='nvim'
alias vi='nvim'
alias v='nvim'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias dotfiles-reload='source $HOME/.bashrc'

alias p="cd $PROJECTS"
alias p.="cd $PROJECTS/dotfiles"
alias p..="cd $PROJECTS/mk-tasks"
alias p...="cd $PROJECTS/openresty-existdb"
alias p1="cd $PROJECTS/gmack.nz"

alias pe.="cd $PROJECTS/dotfiles && nvim" 


