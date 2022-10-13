#!/bin/bash

source .env
WORKDIR=/utkusarioglu/projects/nextjs-grpc/e2e

if [ ! -f $(/var/run/docker.sock) ];
then
  echo "This script requires docker to be available in the environment"
  echo "If you are inside the devcontainer, try running the script from the host."
  exit 1
fi

docker run \
  --rm \
  -t \
  -v $(pwd)/.cypress:$WORKDIR/cypress \
  -v $(pwd)/scripts:$WORKDIR/scripts \
  -v $(pwd)/cypress.config.js:$WORKDIR/cypress.config.js \
  -w $WORKDIR \
  --env-file $(pwd)/.env \
  --name nextjs-grpc-e2e \
  --add-host target-http-server:host-gateway \
  --entrypoint scripts/run-cypress-tests.js \
  cypress/included:10.0.0 
