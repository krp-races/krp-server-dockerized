if [ ! -f ".wine-mono-installed" ]; then
    echo "Installing Wine Mono..."
    WINEDEBUG=-all wine msiexec /i wine-mono.msi /qn
    rm wine-mono.msi
    cat > .wine-mono-installed
    echo "Done..."
else
    echo "Wine Mono already installed..."
fi

echo "Setup Xvfb..."
Xvfb :99 -screen 0 1024x768x16 &
export DISPLAY=:99
echo "Done..."

echo "Server started..."
wine kart.exe -dedicated ${SERVER_PORT} -set params ${SERVER_CONFIG}
echo "Server stopped..."