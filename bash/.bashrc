#!/bin/bash +x

source /usr/share/defaults/etc/profile

if [ -d $HOME/.config/bash ] ; then
    for script in $HOME/.config/bash/*.sh
    do
      # echo  $script
      source $script
    done
    unset script
fi

# show available tmux sessions
if [[ -z $TMUX ]]; then
    sessions=$( tmux ls 2> /dev/null | awk '! /attached/ { sub(":", "", $1); print $1; }' | xargs echo )
    if [[ ! -z $sessions ]]; then
        echo "==> Available tmux sessions: $sessions"
    fi
    unset sessions
fi

source $HOME/projects/owners/ingydotnet/git-subrepo/.rc
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/gmack/google-cloud-sdk/path.bash.inc' ]; then source '/home/gmack/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/gmack/google-cloud-sdk/completion.bash.inc' ]; then source '/home/gmack/google-cloud-sdk/completion.bash.inc'; fi
# create a nvim instance on startup
# setxkbmap -option caps:swapescape

setxkbmap -option caps:escape


# tmuxp load -2 $HOME/.tmuxp/project.yaml

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# added by travis gem
[ -f /home/gmack/.travis/travis.sh ] && source /home/gmack/.travis/travis.sh
