
# Attach to existing tmux session rather than create a new one if possible.

function tmux () {
	if [[ -n "$*" ]]; then
		command tmux $*
	else
		command tmux attach -d &>/dev/null || command tmux
	fi
}

function not_in_tmux() {
  [ -z "$TMUX" ]
}

function session_exists() {
  tmux list-sessions | sed -E 's/:.*$//' | grep -q "^$1$"
}

function create_detached_session() {
  (TMUX='' tmux new-session -Ad -s "$1")
}



function mxInit(){
  source <( sed 's/=/="/g' config | sed -r 's/$/"/g' )
  source ../common.properties
  source ../project.properties
  clear
}

function mxGitHead(){
  git rev-parse --short HEAD
}

function mxNginxAccessLog(){
  tailf -n 1 /var/log/nginx/file.log |
  awk '{ printf("%-15s\t%s\t%s\t%s\n", $1,  $6, $9, $7)}'
}

function mxNginxErrorLog(){
  tailf /var/log/nginx/error.log |
  grep -oP '"(.+)"\sdoes not match\s"(\S+)"'
}

function mxNginxErrorLogMatches(){
  tailf /var/log/nginx/error.log |
  grep -oP '"(.+)"\smatches\s"(\S+)"'
}

function mxExistUp(){
  curl -I 'http://localhost:8080/' |
  grep -oP '(\KJetty.+$)' 2>/dev/null
}

function mxExistClient(){
  cd $EXIST_HOME
  java -jar start.jar client -s -P $GITHUB_ACCESS_TOKEN -u $GIT_REPO_OWNER_LOGIN
}

function mxExistDBLog(){
  mxInit
  tailf "${XMLDB_LOG}" | awk -v m="\x01" -v N="8" '{$N=m$N; print substr($0,index($0,m)+1)}'
  #awk '{ printf("%-15s\t%s\t%s\t%s\n", $1,  $4, $5 , $8)}'
}

function mxAppDataLog(){
 [ -e '.logs/trigger.log' ] && \
  tailf .logs/trigger.log | \
	awk -v m="\x01" -v N="7" '{$N=m$N; print substr($0,index($0,m)+1)}'
}

get_dir() {
    printf "%s" $(pwd | sed "s:$HOME:~:")
}

function  get_sha() {
    git rev-parse --short HEAD 2>/dev/null
}

mt_time () { #format time just the way I likes it
    if [ `date +%p` = "PM" ]; then
        meridiem="pm"
    else
        meridiem="am"
    fi
    date +"%l:%M$meridiem"|sed 's/ //g'
}


function colors() {
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo; echo
	done
}
