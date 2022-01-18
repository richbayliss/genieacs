#!/usr/bin/env bash

set -e

fatal () {
    echo "$1"
    exit
}

COMPONENTS=(
    "ui"
    "cwmp"
    "fs"
    "nbi"
);

PUSH="${DOCKER_PUSH:-}"
TAG="$(echo ${GIT_BRANCH} | tr [:punct:] - | tr [:upper:] [:lower:])"

[ ! -z $TAG ] || fatal "No branch name was set in GIT_BRANCH"
echo "Building images tagged :: $TAG"


for COMPONENT in "${COMPONENTS[@]}"; do
    # Swap `echo` for `nmap` to actually scan
    docker build -t "ghcr.io/richbayliss/genieacs/$COMPONENT:$TAG" --target "$COMPONENT" .

    if [ ! -z $DOCKER_PUSH ]; then
        docker push "ghcr.io/richbayliss/genieacs/$COMPONENT:$TAG"
    fi
done

