#!/usr/bin/env bash
source ./env.sh

if [ -z "$FA_PROXY_ACCESS_USERNAME" ]; then echo "Error: FA_PROXY_ACCESS_USERNAME not set. Exit"; exit 1; fi
if [ -z "$FA_PROXY_ACCESS_PASSWORD" ]; then echo "Error: FA_PROXY_ACCESS_PASSWORD not set. Exit"; exit 1; fi
if [ -z "$FA_PROXY_APP_PORT" ]; then echo "Error: FA_PROXY_APP_PORT not set. Exit"; exit 1; fi
if [ -z "$FA_PROXY_REDIRECT_URL" ]; then echo "Error: FA_PROXY_REDIRECT_URL not set. Exit"; exit 1; fi

docker-compose up --build -d
