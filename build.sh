#!/usr/bin/env bash

function show_help () {
    echo "Usage: build.sh [OPTION]..."
    echo
    echo "  -t, --tag               Tag of nextcloud docker image"
    echo "  -r, --repository        Docker repository to tag and push the image to"
}

[[ -f .env ]] && source .env

while [[ $# -gt 0 ]]; do
    case $1 in
        -t|--tag)
            TAG="$2"; shift; shift ;;
        -r|--repository)
            REPO="$2"; shift; shift ;;
        -h|--help)
            show_help; exit 0 ;;
        -*|--*)
            echo "Unknown option $1"; exit 1 ;;
        *)
            shift ;;
    esac
done

if [[ -z "$TAG" ]]; then
    echo "Error: tag is missing"; echo
    show_help
    exit 1
fi

FULL_TAG=${REPO:+$REPO:}$TAG
echo "Building $FULL_TAG"

docker build --build-arg TAG=$TAG -t $FULL_TAG .
  
if [[ ! -z "$REPO" ]]; then
    read -r -p "Push $FULL_TAG? [y/n] " input
    case $input in
        [yY][eE][sS]|[yY])
            docker push $FULL_TAG
            ;;
        *)
            exit 0
            ;;
    esac
fi