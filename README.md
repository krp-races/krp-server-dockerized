# KRP Server Dockerized

A docker image for running a kart racing pro server. The source is available [on Github](https://github.com/krp-races/krp-server-dockerized).

Images are based on Debian 12.

## Installing

```sh
docker pull krpraces/krp-server-dockerized
```

## Running Containers

### Docker Run

```sh
docker run -P -it --rm krpraces/krp-server-dockerized
```

### Docker Compose

```yml
services:
    krp-server:
        image: krpraces/krp-server-dockerized
        restart: always
        volumes:
            # Commented ones only work when using own server.ini. 
            # Files and folder need to exist in this folder before starting.
            #- ./server.ini:/opt/krp-server/server2.ini
            #- ./whitelist.ini:/opt/krp-server/whitelist.ini
            #- ./blacklist.ini:/opt/krp-server/blacklist.ini
            #- ./results:/opt/krp-server/results
            #- ./replays:/opt/krp-server/replays
            - ./mods:/opt/krp-server/mods
        networks:
            - public
        ports:
            - 54411:54411
            - 54411:54411/udp
            # These ports are only used when using livetiming or remote admin.
            #- 54412:54412
            #- 54412:54412/udp
            #- 54413:54413
            #- 54413:54413/udp
        env:
            # Sets path to server configuration based on krp path.
            #SERVER_CONFIG: server2.ini

networks:
    public:

```

## Constribute

Guidelines are defined [here](https://github.com/krp-races/krp-server-dockerized/blob/main/CONTRIBUTING.md).

## License

Released under the [AGPL-3.0 License](https://github.com/krp-races/krp-server-dockerized/blob/main/LICENSE).