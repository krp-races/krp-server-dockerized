echo "Installing Wine Mono..."
wget https://dl.winehq.org/wine/wine-mono/9.3.0/wine-mono-9.3.0-x86.msi
WINEDEBUG=-all wine msiexec /i wine-mono-9.3.0-x86.msi /qn
rm wine-mono-9.3.0-x86.msi
echo "Done..."

echo "Setup Xvfb..."
Xvfb :99 -screen 0 1024x768x16 &
export DISPLAY=:99
echo "Done..."

echo "Installing KRP Server..."
ls
wine krp-installer.exe -extract
unzip krp.zip
rm krp-installer.exe
rm krp.zip
echo "Done..."

echo "Server started..."
wine kart.exe -dedicated 54411
echo "Server stopped..."