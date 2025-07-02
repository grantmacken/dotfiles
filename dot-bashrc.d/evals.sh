# source $HOME/.atuin/bin/env
if [ -f /run/.toolboxenv ]
then
eval "$(zoxide init bash)"
eval "$(gh copilot alias -- bash)"
# eval "$(direnv hook bash)"
# eval "$(atuin init bash)"
fi

