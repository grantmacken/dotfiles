if [ -f "/run/.toolboxenv" ]
then
  export SHELL=/usr/bin/bash
  export EDITOR="nvim"
else
 export SHELL=/usr/bin/bash
fi

export NPM_CONFIG_USERCONFIG="$HOME/.config/npm/npmrc"

