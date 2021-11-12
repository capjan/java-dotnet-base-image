#!/bin/zsh

# make all requests to unset environment variables an error
set -u

docker login -u $DOCKER_USER -p $DOCKER_ACCESS_TOKEN
docker push $DOCKER_USER/java-dotnet-base
