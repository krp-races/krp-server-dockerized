# KRP-Server-Dockerized

# Base Image
FROM debian:latest

# Author
LABEL maintainer="info@fynnhaupt.de"

# Set working directory
ENV HOME=/opt/krp-server
RUN mkdir ${HOME}
WORKDIR ${HOME}

# Add contrib repository
RUN sed -i -e "s/main/main contrib/g" /etc/apt/sources.list.d/debian.sources

# Update and Upgrade
RUN apt-get update && apt-get upgrade -y

# Install wget and unzip
RUN apt-get install -y wget unzip

# Add i386 architecture
RUN dpkg --add-architecture i386

# Add winehq repository key
RUN mkdir -pm755 /etc/apt/keyrings; \
    wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key

# Add winehq repository
ADD https://dl.winehq.org/wine-builds/debian/dists/bookworm/winehq-bookworm.sources /etc/apt/sources.list.d/winehq-bookworm.sources
RUN apt-get update

# Install winehq-stable and xvfb
RUN apt install -y --install-recommends winehq-stable xvfb

# Hide wine fixme warnings
ENV WINEDEBUG=fixme-all

# Download Wine-Mono
ARG WINE_MONO_URL="https://dl.winehq.org/wine/wine-mono/9.3.0/wine-mono-9.3.0-x86.msi"
ADD ${WINE_MONO_URL} wine-mono.msi

# Download Kart Racing Pro
ARG KRP_URL="https://www.kartracing-pro.com/downloads/krp-rel13e.exe"
ADD ${KRP_URL} krp-installer.exe

# Server Config
ENV SERVER_CONFIG="server.ini"

# Configure Kart Racing Pro
COPY ./configs/server.ini ${HOME}/server.ini
COPY ./configs/global.ini ${HOME}/global.ini

# Copy Scripts
COPY ./scripts/start.sh ${HOME}/start.sh
RUN chmod +x start.sh

# Expose Ports
EXPOSE 54411
EXPOSE 54411/udp
EXPOSE 54412
EXPOSE 54412/udp
EXPOSE 54413
EXPOSE 54413/udp

# Start Command
ENTRYPOINT [ "/bin/sh", "-c", "${HOME}/start.sh" ]