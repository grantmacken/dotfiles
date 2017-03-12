#!/bin/bash
if [[ ! "$PATH" == */home/gmack/bin* ]]; then
  export PATH="$PATH:/home/gmack/bin"
fi

PROJECTS="$HOME/projects/$(git config user.name)"

if [[ ! "$PATH" == *${PROJECTS}/bin* ]]; then
  export PATH="$PATH:${PROJECTS}/bin"
fi

alias vim='nvim'
alias vi='nvim'
alias v='nvim'

# Attach to existing tmux session rather than create a new one if possible.
function tmux () {
	if [[ -n "$*" ]]; then
		command tmux $*
	else
		command tmux attach -d &>/dev/null || command tmux
	fi
}

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

alias fold="fold -s" 


