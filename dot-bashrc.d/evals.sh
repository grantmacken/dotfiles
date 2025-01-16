
if [ -f /run/.toolboxenv ]
then
eval "$(zoxide init bash)"
eval "$(gh copilot alias -- bash)"
fi

