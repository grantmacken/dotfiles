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
#vim now nvim
alias vim='nvim'
alias vi='nvim'
alias v='nvim'

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
alias p...="cd $PROJECTS/openresty-existdb"
alias p1="cd $PROJECTS/gmack.nz"


alias dbStop="sudo systemctl stop exist.service"
alias dbStatus="sudo systemctl status exist.service"
alias dbStart="sudo systemctl start exist.service"
alias ngStop="sudo systemctl stop nginx.service"
alias ngStatus="sudo systemctl status nginx.service"
alias ngStart="sudo systemctl start nginx.service"


alias dbLog="journalctl -u exist.service -o cat -f"
alias ngLog="journalctl -u nginx.service -o cat -f"
alias xmldbLog="tail -f -n 40 /usr/local/eXist/webapp/WEB-INF/logs/xmldb.log  | grep -oP '^(\d{4}-\d{2}-\d{2}).+$'"
alias restxqLog="less /usr/local/eXist/webapp/WEB-INF/logs/restxq.log"

alias tpInstall="~/.tmux/plugins/tpm/bin/install_plugins"
alias tpUpdate="~/.tmux/plugins/tpm/bin/update_plugins"
#alias tmux='TERMINFO=/usr/share/terminfo/x/xterm-16color TERM=xterm-16color tmux -2'
alias featon="ssh featon -t tmux a"
