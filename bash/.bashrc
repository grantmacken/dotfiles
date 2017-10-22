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
# source /usr/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh



[ -f ~/.fzf.bash ] && source ~/.fzf.bash
