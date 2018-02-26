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

source $HOME/projects/owners/ingydotnet/git-subrepo/.rc

# create a nvim instance on startup
setxkbmap -option caps:swapescape
if [[ ! -e $NVIM_LISTEN_ADDRESS ]] ; then
  nvim
fi


[ -f ~/.fzf.bash ] && source ~/.fzf.bash
