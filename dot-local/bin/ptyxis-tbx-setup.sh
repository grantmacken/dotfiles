#!/usr/bin/bash
set -eu -o pipefail
if [ -f "/run/.toolboxenv" ] ; then
  echo -e " - do not run in a toolbox \n - exiting ..."
  exit 1
fi

CONTAINER_NAME=zie-toolbox
IMAGE=ghcr.io/grantmacken/${CONTAINER_NAME}

# echo  ${CONTAINER_ID}
# echo  ${DEFAULT_CONTAINER}

# if [ "${CONTAINER_ID}" = "${DEFAULT_CONTAINER}" ]  ; then
#   echo -e " - already set so nothing to do \n - exiting ..."
#   exit 0
# fi

echo " ---------------------------------------"
echo " Recreate the toolbox container ${CONTAINER_NAME} "
echo " ---------------------------------------"
if toolbox list containers | grep -q "${CONTAINER_NAME}"
   then
   echo " - 1: Remove the toolbox container ${CONTAINER_NAME} "
   toolbox rm -f ${CONTAINER_NAME} &>/dev/null
   echo " - 2: Recreate toolbox from the latest image and" 
   echo "      give it the same name as the removed container"
   toolbox create --image $IMAGE:latest ${CONTAINER_NAME} &>/dev/null
fi
CONTAINER_ID=$(podman inspect ${CONTAINER_NAME} | grep -oP '"Id": "\K(\w)+')
echo " - The toolbox container has ID: ${CONTAINER_ID} "

PROFILE_UUID=$(dconf read /org/gnome/Ptyxis/default-profile-uuid | tr -d "'")
PROFILE_LABEL=${CONTAINER_NAME}
PROFILE_PALETTE=Kanagawa
PROFILE_DEFAULT_CONTAINER=${CONTAINER_ID}
echo  " ---------------------------------------"
echo " Setup the Ptyxis default profile       "
echo " ---------------------------------------"
echo " With the Ptyxis default profile uuid: $PROFILE_UUID"
echo " - 1: set the label:  ${PROFILE_LABEL} "
dconf write /org/gnome/Ptyxis/Profiles/${PROFILE_UUID}/label "'${PROFILE_LABEL}'"
echo " - 2: set the palette:  ${PROFILE_PALETTE} "
dconf write /org/gnome/Ptyxis/Profiles/${PROFILE_UUID}/palette "'$PROFILE_PALETTE'"
echo " - 3: set the default container :  ${PROFILE_DEFAULT_CONTAINER}"
dconf write /org/gnome/Ptyxis/Profiles/${PROFILE_UUID}/default-container "'${PROFILE_DEFAULT_CONTAINER}'"

mkdir -p ${HOME}/Projects
CUSTOM_NAME=${CONTAINER_NAME}
CUSTOM_BINDING='<Control><Alt>t'
CUSTOM_COMMAND='ptyxis -s -d Projects -- nvim'

echo " ---------------------------------------"
echo " Setup Custom Key Binding: ${CUSTOM_BINDING} "
echo " The key binding opens Ptyxis in the default container: ${CONTAINER_ID}"
echo " This default container is the toolbox container named: $CONTAINER_NAME "
echo " The following custom command is run in this container: '${CUSTOM_COMMAND}'" 
echo " The result is Ptyxis starting Neovim in a Projects directory in the toolbox container"
echo " ---------------------------------------"

# # dconf dump /org/gnome/Ptyxis/Profiles/${PROFILE_UUID}/
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/name "'${CUSTOM_NAME}'"
# dconf read /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/name
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/binding "'${CUSTOM_BINDING}'"
# dconf read /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/binding
dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/command "'${CUSTOM_COMMAND}'"
#dconf read /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/command

echo "==========================================================="
echo " - view Ptyxis default profile changes made via dconf dump "
echo "==========================================================="
dconf dump /org/gnome/Ptyxis/Profiles/${PROFILE_UUID}/
echo
echo "==========================================================="
echo " - view Ptyxis default profile changes made via dconf dump "
echo "==========================================================="
dconf dump /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/
echo
echo "==========================================================="
