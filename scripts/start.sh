echo "Installing Wine Mono..."
WINEDEBUG=-all wine msiexec /i wine-mono.msi /qn
echo "Done..."

echo "Setup Xvfb..."
Xvfb :99 -screen 0 1024x768x16 &
export DISPLAY=:99
echo "Done..."

echo "Installing KRP Server..."
wine krp-installer.exe -extract
unzip krp.zip
echo "Done..."

echo "Server started..."
wine kart.exe -dedicated 54411
echo "Server stopped..."