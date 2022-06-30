ARG TAG

FROM nextcloud:$TAG

RUN apt-get update; \
    apt-get install -y --no-install-recommends \
        ffmpeg