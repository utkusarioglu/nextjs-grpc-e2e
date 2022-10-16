#!/bin/bash

WORKDIR=/utkusarioglu-com/projects/nextjs-grpc/e2e
source "$WORKDIR/.env"
repo_dir="$GITHUB_WORKSPACE/e2e"

if [ ! -f $(/var/run/docker.sock) ];
then
  echo "This script requires docker to be available in the environment"
  echo "If you are inside the devcontainer, try running the script from the host."
  exit 1
fi

docker run \
  --rm \
  -t \
  -v "$repo_dir/.env:$WORKDIR/.env" \
  -v "$repo_dir/.cypress:$WORKDIR/cypress" \
  -v "$repo_dir/scripts:$WORKDIR/scripts" \
  -v "$repo_dir/cypress.config.js:$WORKDIR/cypress.config.js" \
  -v "$repo_dir/package.json:$WORKDIR/package.json" \
  -w $WORKDIR \
  --network host \
  --name nextjs-grpc-e2e \
  --add-host "$BASE_URL:127.0.0.1" \
  --entrypoint scripts/run-cypress-tests.sh \
  cypress/included:10.0.0 \
