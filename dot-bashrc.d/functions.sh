

# https://docs.fedoraproject.org/en-US/fedora-silverblue/tips-and-tricks/

function is_toolbox() {
    if [ -f "/run/.toolboxenv" ]
    then
        TOOLBOX_NAME=$(cat /run/.containerenv | grep -oP "(?<=name=\")[^\";]+")
        echo "[${HOSTNAME} ${TOOLBOX_NAME}]"
    fi
}

export -f is_toolbox


