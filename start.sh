# /bin/bash

echo "Setting up edgeshark on http://localhost:5001/"
# Install edgeshark
wget -q --no-cache -O - \
  https://github.com/siemens/edgeshark/raw/main/deployments/wget/docker-compose-localhost.yaml \
  | DOCKER_DEFAULT_PLATFORM= docker compose -f - up --detach

# Run the restart command on a new tab
gnome-terminal --tab -e "./restart.sh"

# Startup the server/client
docker compose up --build