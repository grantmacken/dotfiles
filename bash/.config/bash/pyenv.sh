#!/bin/bash
if [[ ! "$PATH" == */home/gmack/.pyenv/bin/bin* ]]; then
  export PATH="$PATH:/home/gmack/.pyenv/bin"
fi

[ -n $(which pyenv) ] && eval "$(pyenv init -)"
[ -n $(which pyenv) ] &&  eval "$(pyenv virtualenv-init -)"

