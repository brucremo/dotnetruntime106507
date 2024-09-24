# Once the client hangs, get the dotnet dump
$timestamp = (Get-Date).ToString("yyyyMMdd_HHmmss")
docker exec -t dummy_client powershell -Command "dotnet-dump collect --process-id 1 --output /app/dumps/$timestamp.dmp"