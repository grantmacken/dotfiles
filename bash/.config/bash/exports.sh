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
HOME_BIN="$HOME/bin"
if [[ ! "$PATH" == *${HOME_BIN}* ]]; then
  export PATH="$PATH:${HOME_BIN}"
fi

# git controlled project development
 
GIT_USER="$( git config --get user.name )"
# if we have a user name set a PROJECTS folder
if [ -n "${GIT_USER}" ]; then
  export GIT_USER="${GIT_USER}"
  PROJECTS="$HOME/projects/${GIT_USER}"
  export PROJECTS="${PROJECTS}"
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

  # EXPORT ACCESS TOKENS stores in projects dir
  GITHUB_ACCESS_TOKEN=$(<"${PROJECTS}/.github-access-token")
  export GITHUB_ACCESS_TOKEN=$GITHUB_ACCESS_TOKEN
  GIT_USER=$(git config user.name)
  export GIT_USER=$GIT_USER
  EXIST_AUTH=$(echo -n "$GIT_USER:$GITHUB_ACCESS_TOKEN" | base64)
  export EXIST_AUTH="$EXIST_AUTH"

  JWT_AUTH_TOKEN=$(<"${PROJECTS}/.site-access-token")
  # this is used by httpie
  export JWT_AUTH_TOKEN=$JWT_AUTH_TOKEN
  export SITE_ACCESS_TOKEN=$JWT_AUTH_TOKEN

  alias p="cd $PROJECTS"
  alias p.="cd $PROJECTS/dotfiles"
  alias p..="cd $PROJECTS/accounts"
  alias p...="cd $PROJECTS/openresty-existdb"
  alias p1="cd $PROJECTS/gmack.nz"

  COMMON_PROPERTIES=$PROJECTS/common.properties
  if [ -e ${COMMON_PROPERTIES} ] ; then
    source ${COMMON_PROPERTIES}
     # ssh into
    export SSH="${SSH}"
    export OPENRESTY_HOME="${OPENRESTY_HOME}"
    # exist
    export EXIST_HOME="${EXIST_HOME}"

    # eXist has saxon
    export SAXON_HOME="${EXIST_HOME}/lib/endorsed"
    #SAXON=$(ls ${SAXON_HOME} | grep -oP '^Saxon(.+)\.jar$')
    #export SAXON="${SAXON}"
    # eXist has ant
    export ANT_HOME="${EXIST_HOME}/tools/ant/lib"
    export NS="${NS}"
    export REPO_BASE_URL="${REPO_BASE_URL}"
  fi

  LEDGER_FILE=${PROJECTS}/accounts/main.ledger
  export LEDGER_FILE="${LEDGER_FILE}"
  LEDGER_PRICE_DB=${PROJECTS}/accounts/pricedb.ledger
  export LEDGER_PRICE_DB="${LEDGER_PRICE_DB}"

  LEDGER_INIT_FILE=~/.ledgerrc
  export LEDGER_INIT_FILE="${LEDGER_INIT_FILE}"
  # Equivalent to %Y-%m-%d (the ISO 8601 date format). (C99
  LEDGER_DATE_FORMAT=%F
  export LEDGER_DATE_FORMAT="${LEDGER_DATE_FORMAT}"
fi

# to build exist we need to
JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:/bin/java::")
export JAVA_HOME=${JAVA_HOME}

export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket
export EDITOR='nvr --remote-wait-silent'
export GIT_EDITOR="$EDITOR"
export VISUAL="$EDITOR"



