#!/bin/zsh

# make all requests to unset environment variables an error
set -u

docker build -t $DOCKER_USER/java-dotnet-base .
