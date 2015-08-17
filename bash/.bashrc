# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

[ -f ~/.bash_env ] &&  source ~/.bash_env
[ -f ~/.bash_aliases ] &&  source ~/.bash_aliases
[ -f ~/.bash_functions ] &&  source ~/.bash_functions
[ -f ~/.bash_prompt ] &&  source ~/.bash_prompt
