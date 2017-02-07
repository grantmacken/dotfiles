source /usr/share/defaults/etc/profile

if [ -d $HOME/.config/bash ] ; then
    for script in $HOME/.config/bash/*.sh
    do
      # echo  $script
      source $script
    done
    unset script
fi

# source /usr/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh
