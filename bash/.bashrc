# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
#[ -z "$PS1" ] && return

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

setxkbmap -option 'caps:ctrl_modifier'
xcape -e 'Caps_Lock=Escape;Control_L=Escape;Control_R=Escape'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

#path,prompt,exports,aliases,functions,extra,gitcompletion
for file in ~/.bash_{exports,aliases,functions,prompt}; do
    [ -r "$file" ] && source "$file"
done
unset file
#path,prompt,exports,aliases,functions,extra,gitcompletion

if [ ! "$TERM" = 'xterm-256color' ] ; then
  export TERM=xterm-256color
  source ~/.bash_prompt
fi

#if [ -z "$TMUX" ] ; then
# tmux new-session -As "${BASE_SESSION}"
#else
#    if ! $(session_exists "${BASE_SESSION}" ); then
#      create_detached_session "${BASE_SESSION}"
#    fi
#    tmux switch-client -t "${BASE_SESSION}"
#  fi


# create_if_needed_and_attach

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
