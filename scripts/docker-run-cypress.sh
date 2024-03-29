#!/bin/bash

# WORKDIR=/utkusarioglu-com/projects/nextjs-grpc/e2e
WORKDIR=/cypress-workspace
# CYPRESS_VERSION=12.13.0
CYPRESS_VERSION=12.17.2

if [ -z "$CI" ]; then
  GITHUB_WORKSPACE=$(pwd)/..
fi 

echo "Using GITHUB_WORKSPACE: $GITHUB_WORKSPACE"

if [ -z "$GITHUB_WORKSPACE" ]; then
  echo "env.GITHUB_WORKSPACE is required to run this script"
  exit 1
fi

repo_dir="$GITHUB_WORKSPACE/e2e"
source "$repo_dir/.env"

if [ "$(id -u)" != "0" ] && [ ! -f $(/var/run/docker.sock) ];
then
  echo "This script requires docker to be available in the environment"
  echo "If you are inside the devcontainer, try running the script from the host."
  exit 1
fi

docker run \
  --rm \
  --user 0:0 \
  -t \
  -v "$repo_dir/.env:$WORKDIR/.env" \
  -v "$repo_dir/package.json:$WORKDIR/package.json" \
  -v "$repo_dir/scripts:$WORKDIR/scripts" \
  -v "$repo_dir/.cypress:$WORKDIR/cypress" \
  -v "$repo_dir/cypress.config.js:$WORKDIR/cypress.config.js" \
  -v "$repo_dir/.cypress/cache/node_modules:$WORKDIR/node_modules" \
  -v "$repo_dir/.cypress/cache/cypress:/root/.cache/Cypress" \
  -v "$repo_dir/.yarnrc.yml:$WORKDIR/.yarnrc.yml" \
  -v "$repo_dir/.yarn:$WORKDIR/.yarn" \
  -v "$repo_dir/yarn.lock:$WORKDIR/yarn.lock" \
  -w $WORKDIR \
  --network host \
  --name nextjs-grpc-e2e \
  --add-host "$BASE_URL:127.0.0.1" \
  --entrypoint scripts/run-cypress-tests.sh \
  cypress/included:$CYPRESS_VERSION

  # --privileged \
