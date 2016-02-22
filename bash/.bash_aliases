# some more ls aliases

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi


alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias dotfiles-reload='source $HOME/.bashrc'

alias p="cd $PROJECTS"
alias p.="cd $PROJECTS/dotfiles"
alias p..="cd $PROJECTS/mk-tasks"
alias p...="cd $PROJECTS/nginx-exist"   
alias p1="cd $PROJECTS/gmack.nz"
alias tp.="cd $PROJECTS/dotfiles;tmux attach -t dotfiles"
alias tp..="cd $PROJECTS/mk-tasks;tmux attach -t tasks"
alias tp-tasks="cd $PROJECTS/mk-tasks;tmux attach -t tasks"
alias tp...="cd $PROJECTS/nginx-exist;tmux attach -t servers"   
alias tp-servers="cd $PROJECTS/nginx-exist;tmux attach -t servers"   
alias tp1="cd $PROJECTS/gmack.nz;tmux attach -t gmack"
alias tp-gmack="cd $PROJECTS/gmack.nz;tmux attach -t gmack"

alias tpInstall="~/.tmux/plugins/tpm/bin/install_plugins"
alias tpUpdate="~/.tmux/plugins/tpm/bin/update_plugins"
#alias tmux='TERMINFO=/usr/share/terminfo/x/xterm-16color TERM=xterm-16color tmux -2'
