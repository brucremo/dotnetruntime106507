$COUNTER = 1

# Restart the server container every 30 seconds indefinitely
while ($true) {
    Start-Sleep -Seconds 30
    Write-Host "Restart #$COUNTER"
    $COUNTER++
    docker container restart dummy_api | Out-Null
}
