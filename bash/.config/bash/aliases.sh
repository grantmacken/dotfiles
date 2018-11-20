#!/bin/bash
# create a nvim instance on startup
# if [[ ! -e /tmp/nvimsocket ]] ; then
#   nvim
# fi

# alias h='nvr -o'
# alias v='nvr -O'
# alias t='nvr --remote-tab'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias dotfiles-reload='source $HOME/.bashrc'

alias fold="fold -s"

alias p="cd $HOME/projects/$( git config --get user.name )"
alias p.="cd $HOME/projects/$( git config --get user.name )/dotfiles"
alias pA="cd $HOME/projects/$( git config --get user.name )/accounts"
alias pD="cd $HOME/projects/$( git config --get user.name )/dorex"

# alias tmx="pD && tmux new-session -s dorex -t $( git config --get user.name )"

alias SSH='gcloud compute ssh gmack'


#alias featon='ssh featon -t tmux a'
