if [ -f "/run/.toolboxenv" ]; then
  export SHELL=/usr/bin/bash
  export EDITOR="nvim"
else
  export SHELL=/usr/bin/bash
fi

GEMINI_API_KEY=$(cat "$HOME/Projects/.gemini-api-key")
export GEMINI_API_KEY
export NPM_CONFIG_USERCONFIG="$HOME/.config/npm/npmrc"

if [ -f /run/.containerenv ]; then
  PTYXIS_PROFILE=$(host-spawn dconf read /org/gnome/Ptyxis/default-profile-uuid |
    tr -d "'")
else
  PTYXIS_PROFILE=$(dconf read /org/gnome/Ptyxis/default-profile-uuid | tr -d "'")
fi

export PTYXIS_PROFILE
