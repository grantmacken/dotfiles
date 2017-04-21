#!/bin/bash
if [[ ! "$PATH" == */home/gmack/.local/bin* ]]; then
  export PATH="$PATH:/home/gmack/.local/bin"
fi

if [[ ! "$PATH" == */home/gmack/.pyenv/bin* ]]; then
  export PATH="$PATH:/home/gmack/.pyenv/bin"
fi
[ -n $(which pyenv) ] && eval "$(pyenv init -)"
[ -n $(which pyenv) ] &&  eval "$(pyenv virtualenv-init -)"

