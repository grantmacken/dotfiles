#!/bin/bash
# git clone git://github.com/yyuu/pyenv.git ~/.pyenv
# pyenv root
export PYENV_ROOT="$HOME/.pyenv"

if [[ ! "$PATH" == *$HOME/.local/bin* ]]; then
  export PATH="$PATH:$HOME/.local/bin"
fi

if [[ ! "$PATH" == *$PYENV_ROOT/bin* ]]; then
  export PATH="$PATH:$PYENV_ROOT/bin"
fi
[ -n "$(which pyenv)" ] && eval "$(pyenv init -)"
[ -n "$(which pyenv)" ] &&  eval "$(pyenv virtualenv-init -)"

