# Set the URL for the edgeshark installation
$edgesharkUrl = "https://github.com/siemens/edgeshark/raw/main/deployments/wget/docker-compose-localhost.yaml"

Write-Host "Setting up edgeshark on http://localhost:5001/"

# Install edgeshark
Invoke-WebRequest -Uri $edgesharkUrl -OutFile "docker-compose-localhost.yaml"
$env:DOCKER_DEFAULT_PLATFORM = ""
docker-compose -f "docker-compose-localhost.yaml" up --detach

# Run the restart command in a new PowerShell window
Start-Process powershell -ArgumentList "-NoExit", "-Command", "./restart.ps1"

# Startup the server/client
docker-compose up --build
