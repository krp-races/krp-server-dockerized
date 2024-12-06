echo "Setup Virtual Display..."
Xvfb :99 -screen 0 1024x768x16 &
export DISPLAY=:99
echo "Done..."

echo "Server started..."
wine kart.exe -dedicated ${SERVER_PORT} -set params ${SERVER_CONFIG}
echo "Server stopped..."