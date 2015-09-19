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

#http://www.economyofeffort.com/2014/08/11/beyond-ctrl-remap-make-that-caps-lock-key-useful

#isetxkbmap -layout us -option 'ctrl:nocaps'

#TODO test
#stty -ixon


#BASE_SESSION="$(git config user.name)"
#isTmuxRunning="$(ps -e | grep -q tmux)"
#echo "CHECK! - is Tmux running?"
#echo "BASE_SESSION: ${BASE_SESSION}"

#if [ -z "${isTmuxRunning}" ] ; then
#	tmux new-session -d -s ${BASE_SESSION}
#	tmux attach -t
#   #Simply creates a new base session named "main" if none exists
#   # and detach
#fi
#if [ ! "$TERM" = 'screen-256color' ] ; then
#  export TERM=xterm-256color
#  source ~/.bash_prompt
#  tmux new-session -d -s ${BASE_SESSION}
#fi
#sudo apt-get install xvba-va-driver
#sudo add-apt-repository ppa:nilarimogard/webupd8
#sudo apt-get update
#sudo apt-get install libvdpau-va-gl1
#sudo sh -c "echo 'export VDPAU_DRIVER=va_gl' >> /etc/profile"
#sudo mkdir /etc/adobe
#sudo echo -e "EnableLinuxHWVideoDecode = 1\nOverrideGPUValidation = 1" | sudo tee /etc/adobe/mms.cfg




[ -f ~/.fzf.bash ] && source ~/.fzf.bash
