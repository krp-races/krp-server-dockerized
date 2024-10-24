# KRP-Server-Dockerized

# Base Image
FROM mcr.microsoft.com/windows/server:ltsc2022

# Author
LABEL maintainer="info@fynnhaupt.de"

# Activate PowerShell
SHELL ["powershell"]

# Set working directory
ENV HOME=C:\\krp-server
RUN New-Item -ItemType Directory $env:HOME
WORKDIR ${HOME}

# Download Kart Racing Pro
ARG DOWNLOAD_URL="https://www.kartracing-pro.com/downloads/krp-rel13e.exe"
ADD ${DOWNLOAD_URL} krp-installer.exe

# Extract Kart Racing Pro
RUN ./krp-installer.exe -extract

# Install Kart Racing Pro
RUN Expand-Archive -Path $env:Home\krp.zip -DestinationPath $env:Home; \
    Remove-Item $env:Home\krp-installer.exe; \
    Remove-Item $env:Home\krp.zip

# Configure Kart Racing Pro
COPY ./scripts/start.ps1 ${HOME}/start.ps1
COPY ./configs/server.ini ${HOME}/server.ini
COPY ./configs/global.ini ${HOME}/global.ini

ARG SERVER_CONFIG="server.ini"
ENV SERVER_CONFIG ${SERVER_CONFIG}

# Expose ports
EXPOSE 54411
EXPOSE 54412
EXPOSE 54413

ENTRYPOINT [ "powershell", "./start.ps1" ]