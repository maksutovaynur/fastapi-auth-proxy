#!/usr/bin/env bash

DOCKER_BUILDKIT=1 COMPOSE_DOCKER_CLI_BUILD=1 COMPOSE_PROJECT_NAME=fastapi-proxy docker-compose up --build -d
