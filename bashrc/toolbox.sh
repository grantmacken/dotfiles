PROJECTS=${HOME}/zie
if podman images | grep -q ghcr.io/grantmacken/zie-toolbox
then
  echo 'TOOLBOX_IMAGE=ghcr.io/grantmacken/zie-toolbox' > "${PROJECTS}/.env"
fi
