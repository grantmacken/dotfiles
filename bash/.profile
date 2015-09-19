# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
#if [ -n "$BASH_VERSION" ]; then
#    # include .bashrc if it exists
#    if [ -f "$HOME/.bashrc" ]; then
#	source "$HOME/.bashrc"
#    fi
#fi

#    1) .bash_profile is loaded the first time you login, and should be used
#       only for paths and environmental settings

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
# set PATH so it includes user's projects bin if it exists
export BASE_SESSION="$(git config user.name)"
if [ -n "${BASE_SESSION}" ] ; then
    export PROJECTS="$HOME/projects/${BASE_SESSION}"
	if [ -d "$PROJECTS/bin" ] ; then
        [[ $PATH == ?(*:)$PROJECTS/bin?(:*) ]] || PATH="$PROJECTS/bin:$PATH"
    fi
    if [ -d "$PROJECTS/node_modules/.bin" ] ; then
		[[ $PATH == ?(*:)$PROJECTS/node_modules/.bin?(:*) ]] || PATH="$PROJECTS/node_modules/.bin:$PATH"
	fi
fi



##_byobu_sourced=1 . /usr/bin/byobu-launch 2>/dev/null || true
## Case-insensitive globbing (used in pathname expansion)
#shopt -s nocaseglob
#
## append to the history file, don't overwrite it
#shopt -s histappend
#
## Autocorrect typos in path names when using `cd`
#shopt -s cdspell
#
## check the window size after each command and, if necessary,
## update the values of LINES and COLUMNS.
#shopt -s checkwinsize
#
## Enable some Bash 4 features when possible:
## * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
## * Recursive globbing, e.g. `echo **/*.txt`
#for option in autocd globstar; do
#  shopt -s "$option" 2> /dev/null;
#done;
