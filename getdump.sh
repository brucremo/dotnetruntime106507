# /bin/bash

CURRENT_PATH=$(pwd)

# Once the client hangs, get the dotnet dump
docker exec -t dummy_client sh -c "dotnet-dump collect --process-id 1 --output /app/dumps/$(date +%Y%m%d_%H%M%S).dmp"

cd dumps
sudo chown -R $(whoami) *

cd $CURRENT_PATH