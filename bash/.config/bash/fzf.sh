#!/bin/bash

if [[ ! "$PATH" == */home/gmack/.cargo/bin* ]]; then
  export PATH="$PATH:/home/gmack/.cargo/bin"
fi

if [[ ! "$PATH" == */home/gmack/.fzf/bin* ]]; then
  export PATH="$PATH:/home/gmack/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/gmack/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/gmack/.fzf/shell/key-bindings.bash"

# https://medium.com/@crashybang/supercharge-vim-with-fzf-and-ripgrep-d4661fc853d2
# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
