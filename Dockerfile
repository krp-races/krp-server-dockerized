# KRP-Server-Dockerized

# Base Image
FROM debian:13

# Set working directory
ENV HOME=/opt/krp-server
RUN mkdir ${HOME}
WORKDIR ${HOME}

# Add contrib repository
RUN sed -i -e "s/main/main contrib/g" /etc/apt/sources.list.d/debian.sources

# Update and Upgrade
RUN apt-get update && apt-get upgrade -y

# Install wget and 7zip
RUN apt-get install -y wget p7zip-full

# Add i386 architecture
RUN dpkg --add-architecture i386

# Add winehq repository key
RUN mkdir -pm755 /etc/apt/keyrings; \
    wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key

# Add winehq repository
ADD https://dl.winehq.org/wine-builds/debian/dists/bookworm/winehq-bookworm.sources /etc/apt/sources.list.d/winehq-bookworm.sources
RUN apt-get update

# Install winehq-stable, xvfb
RUN apt install -y --install-recommends winehq-stable xvfb

# Hide wine fixme warnings
ENV WINEDEBUG=fixme-all

# Download Wine-Mono
ARG WINE_MONO_URL="https://dl.winehq.org/wine/wine-mono/9.3.0/wine-mono-9.3.0-x86.msi"
ADD ${WINE_MONO_URL} wine-mono.msi

# Download Kart Racing Pro
ARG KRP_URL="https://www.kartracing-pro.com/downloads/krp-rel14.exe"
ADD ${KRP_URL} krp-installer.exe

# Extract krp server
RUN 7z x krp-installer.exe; \
    rm krp-installer.exe

# Environmental Variables
ENV SERVER_PORT=54411
ENV LIVETIMING_PORT=54412
ENV REMOTEADMIN_PORT=54413
ENV SERVER_CONFIG="server.ini"

# Default Configuration
COPY ./configs/server.ini ${HOME}/server.ini

# Copy Scripts
COPY ./scripts/start.sh ${HOME}/start.sh
RUN chmod +x start.sh

# Expose Ports
EXPOSE ${SERVER_PORT}
EXPOSE ${SERVER_PORT}/udp
EXPOSE ${LIVETIMING_PORT}
EXPOSE ${LIVETIMING_PORT}/udp
EXPOSE ${REMOTEADMIN_PORT}
EXPOSE ${REMOTEADMIN_PORT}/udp

# Start Command
ENTRYPOINT [ "/bin/sh", "-c", "${HOME}/start.sh" ]