echo "Server started..."
echo "Config: $env:SERVER_CONFIG"
Start-Process -FilePath "kart.exe" -ArgumentList "-dedicated","54411","-set params",$env:SERVER_CONFIG -Wait
echo "Server stopped..."