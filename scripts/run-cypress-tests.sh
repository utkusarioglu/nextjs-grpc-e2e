#!/bin/bash

LOGS_PATH=".cypress/artifacts/logs"
YARN_LOGS_PATH=$LOGS_PATH/yarn.log

mkdir -p $LOGS_PATH
touch $YARN_LOGS_PATH

yarn --frozen-lockfile

echo 'Testing curl:'
curl --insecure https://nextjs-grpc.utkusarioglu.com
echo 'End of curl test'

NODE_EXTRA_CA_CERTS=/utkusarioglu-com/projects/nextjs-grpc/e2e/.certs/ca.crt \
  scripts/run-cypress-tests.js
