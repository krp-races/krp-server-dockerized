echo "Server started..."
x11vnc -display :99 -N -forever & wine kart.exe -dedicated 54411
echo "Server stopped..."