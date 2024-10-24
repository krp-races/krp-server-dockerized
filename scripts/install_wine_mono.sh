echo "Installing Wine Mono..."
wget https://dl.winehq.org/wine/wine-mono/9.3.0/wine-mono-9.3.0-x86.msi
wine WINEDEBUG=-all msiexec /i wine-mono-9.3.0-x86.msi /qn
rm wine-mono-9.3.0-x86.msi
echo "Done..."