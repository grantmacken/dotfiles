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


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# set PATH so it includes user's projects bin if it exists
gitUserName="$(git config --get user.name)"
if [ -n "${gitUserName}" ] ; then
	if [ -d "$HOME/projects/${gitUserName}/bin" ] ; then
		PATH="$HOME/projects/${gitUserName}/bin:$PATH"
	fi
fi

[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"  # This loads nvm

# added by travis gem
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh

#path,prompt,exports,aliases,functions,extra,gitcompletion
for file in ~/.bash_{exports,aliases,functions,prompt}; do
    [ -r "$file" ] && source "$file"
done
unset file

if [ ! "$TERM" = 'xterm-256color' ] ; then
  export TERM=xterm-256color
  source ~/.bash_prompt
fi
