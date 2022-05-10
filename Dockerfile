FROM nextcloud:23.0.4-apache

RUN apt-get update; \
    apt-get install -y --no-install-recommends \
        ffmpeg