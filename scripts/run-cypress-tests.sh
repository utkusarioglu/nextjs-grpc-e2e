#!/bin/bash

#
# scripts/prep-cypress-tests.sh needs to be run before this script
#

# LOGS_PATH=".cypress/artifacts/logs"
# YARN_LOGS_PATH=$LOGS_PATH/yarn.log
CA_PATH=/utkusarioglu-com/projects/nextjs-grpc/e2e/.certs/intermediate/ca.crt

# mkdir -p $LOGS_PATH
# touch $YARN_LOGS_PATH

# yarn --frozen-lockfile
# echo '<Curl install>'
# apt update && apt install -y curl
# echo '</Curl install>'
# echo '<Curl test>'
# curl --insecure https://nextjs-grpc.utkusarioglu.com
# echo '</Curl test>'

echo '<Certificate>'
cat $CA_PATH
echo '</ Certificate>'

echo '<Curl, homepage>'
curl http://nextjs-grpc.utkusarioglu.com
echo '</Curl, homepage>'

echo '<Curl, login>'
curl http://nextjs-grpc.utkusarioglu.com/login
echo '</Curl, login>'

echo '<Curl with ca, homepage>'
curl --cacert $CA_PATH https://nextjs-grpc.utkusarioglu.com
echo '</Curl with ca, homepage>'

echo '<Curl with ca, login>'
curl --cacert $CA_PATH https://nextjs-grpc.utkusarioglu.com/login
echo '</Curl with ca, login>'

NODE_EXTRA_CA_CERTS=$CA_PATH \
  scripts/run-cypress-tests.js
