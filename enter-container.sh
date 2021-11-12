#!/bin/zsh

# make all requests to unset environment variables an error
set -u

docker run --rm -it $DOCKER_USER/java-dotnet-base bash
