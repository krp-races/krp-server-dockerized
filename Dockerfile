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
COPY ./start.ps1 ${HOME}/start.ps1
COPY ./server.ini ${HOME}/server.ini

# Expose ports
EXPOSE 54410
EXPOSE 54411
EXPOSE 54412

ENTRYPOINT [ "powershell" ]
CMD [ "./start.ps1" ]