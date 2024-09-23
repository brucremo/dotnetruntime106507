# /bin/bash

COUNTER=1

# Restart the server container every 30s indefinitely
while true  
do  
  sleep 30  
  echo "Restart #$COUNTER"
  COUNTER=$((COUNTER+1))
  docker container restart dummy_api >> /dev/null
done