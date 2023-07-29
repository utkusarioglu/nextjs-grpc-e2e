#!/bin/bash

LOGS_PATH=".cypress/artifacts/logs"
YARN_LOGS_PATH=$LOGS_PATH/yarn.log

mkdir -p $LOGS_PATH
touch $YARN_LOGS_PATH

yarn --frozen-lockfile

echo '<test code>'
mkdir cypress/artifacts
echo 'from prep file' > cypress/artifacts/prep.txt

pwd
ls
ls cypress
ls cypress/artifacts
cat cypress/artifacts/prep.txt
echo '</test code>'

# echo '<Curl install>'
# apt update && apt install -y curl
# echo '</Curl install>'
# echo '<Curl test>'
# curl --insecure https://nextjs-grpc.utkusarioglu.com
# echo '</Curl test>'

# echo '<Certificate>'
# cat $CA_PATH
# echo '</ Certificate>'

# NODE_EXTRA_CA_CERTS=$CA_PATH \
#   scripts/run-cypress-tests.js
