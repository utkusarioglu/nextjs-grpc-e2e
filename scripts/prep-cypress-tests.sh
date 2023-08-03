#!/bin/bash

LOGS_PATH=".cypress/artifacts/logs"
YARN_LOGS_PATH=$LOGS_PATH/yarn.log

mkdir -p $LOGS_PATH
touch $YARN_LOGS_PATH

yarn --frozen-lockfile

mkdir cypress/artifacts
