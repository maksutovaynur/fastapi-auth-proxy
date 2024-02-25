#!/usr/bin/env bash
source ./env.sh
DOCKER_BUILDKIT=1 COMPOSE_DOCKER_CLI_BUILD=1 COMPOSE_PROJECT_NAME=${FA_PROXY_PROJECT} docker-compose up --build -d
