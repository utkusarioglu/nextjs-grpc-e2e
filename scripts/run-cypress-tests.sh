#!/bin/bash

#
# scripts/prep-cypress-tests.sh needs to be run before this script
#
CA_PATH=/utkusarioglu-com/projects/nextjs-grpc/e2e/.certs/intermediate/ca.crt

echo '<Certificate>'
cat $CA_PATH
echo '</ Certificate>'

NODE_EXTRA_CA_CERTS=$CA_PATH scripts/run-cypress-tests.js

echo '<artifacts folder>'
ls -al /utkusarioglu-com/projects/nextjs-grpc/e2e/cypress/artifacts
echo '</ artifacts folder>'
