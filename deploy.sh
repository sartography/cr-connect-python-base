#!/bin/bash

function branch_to_tag () {
  if [ "$1" == "latest" ]; then echo "production"; else echo "$1" ; fi
}

REPO="sartography/cr-connect-workflow"
TAG=$(branch_to_tag "$TRAVIS_BRANCH")

# Build and push Docker image to Docker Hub
echo "$DOCKER_TOKEN" | docker login -u "$DOCKER_USERNAME" --password-stdin || exit 1
docker build -f Dockerfile -t "$REPO:$TAG" . || exit 1
docker push "$REPO" || exit 1
