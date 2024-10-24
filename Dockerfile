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
RUN wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/bookworm/winehq-bookworm.sources; \
    apt-get update

# Install winehq-stable and xvfb
RUN apt install -y --install-recommends winehq-stable xvfb

# Hide wine fixme warnings
ENV WINEDEBUG=fixme-all

# Download Kart Racing Pro
ARG DOWNLOAD_URL="https://www.kartracing-pro.com/downloads/krp-rel13e.exe"
ADD ${DOWNLOAD_URL} krp-installer.exe

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
CMD [ "${HOME}/start.sh" ]