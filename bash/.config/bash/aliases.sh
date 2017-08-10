#!/bin/bash

if [ -z "$XDG_CONFIG_HOME" ]; then
  export XDG_CONFIG_HOME="$HOME/.config"
fi

if [ -z "$XDG_CACHE_HOME" ]; then
  export XDG_CACHE_HOME="$HOME/.cache"
fi

if [ -z "$XDG_DATA_HOME" ]; then
  export XDG_DATA_HOME="$HOME/.local/share"
fi

# if [ ! -e "XDG_DATA_HOME/nvim/site/pack/minpac/opt" ]; then
#   mkdir -p "$XDG_DATA_HOME/nvim/site/pack/minpac/opt"
#   pushd .
#   cd "$XDG_DATA_HOME/nvim/site/pack/minpac/opt" || exit
#   git clone https://github.com/k-takata/minpac.git
#   popd
# fi
if [ ! -e "$XDG_DATA_HOME/nvim/site/autoload/plug.vim" ]; then
  curl -fLo "$XDG_DATA_HOME/nvim/site/autoload/plug.vim" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

if [ ! -d "$XDG_DATA_HOME/nvim/site/plugged" ]; then
  mkdir -p "$XDG_DATA_HOME/nvim/site/plugged"
fi

# make sure we have a home bin on path
if [[ ! "$PATH" == */home/gmack/bin* ]]; then
  export PATH="$PATH:/home/gmack/bin"
fi

# git controlled project development
PROJECTS="$HOME/projects/$(git config user.name)"

# make sure projects bin on PATH
# @see Makefile in ${PROJECTS}/mk-tasks
if [[ ! "$PATH" == *${PROJECTS}/bin* ]]; then
  export PATH="$PATH:${PROJECTS}/bin"
fi

# dev node bin for my projects
# @see package.json in ${PROJECTS}/
# @see Makefile in ${PROJECTS}/mk-tasks
if [[ ! "$PATH" == *${PROJECTS}/node_modules/.bin* ]]; then
  export PATH="$PATH:${PROJECTS}/node_modules/.bin"
fi

JWT_AUTH_TOKEN=$(<"${PROJECTS}/.site-access-token")
export JWT_AUTH_TOKEN=$JWT_AUTH_TOKEN
export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket
export VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
alias vim='nvim'
alias vi='nvim'
alias v='nvim'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias dotfiles-reload='source $HOME/.bashrc'

alias p="cd $PROJECTS"
alias p.="cd $PROJECTS/dotfiles"
alias p..="cd $PROJECTS/mk-tasks"
alias p...="cd $PROJECTS/openresty-existdb"
alias p1="cd $PROJECTS/gmack.nz"

alias pe.="cd $PROJECTS/dotfiles && nvim"

alias fold="fold -s"


