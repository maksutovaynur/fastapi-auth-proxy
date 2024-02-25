#!/usr/bin/env bash
cd "$(dirname $0)" || exit 1

. "${ENV:-.env}"

export FA_PROXY_PROJECT="${FA_PROXY_PROJECT:-fastapi-proxy}"
export FA_PROXY_ACCESS_USERNAME="${FA_PROXY_ACCESS_USERNAME}"
export FA_PROXY_ACCESS_PASSWORD="${FA_PROXY_ACCESS_PASSWORD}"
export FA_PROXY_APP_HOST="${FA_PROXY_APP_HOST:-127.0.0.1}"
export FA_PROXY_APP_PORT="${FA_PROXY_APP_PORT}"
export FA_PROXY_REDIRECT_URL="${FA_PROXY_REDIRECT_URL}"

printenv | grep FA_PROXY | grep -v PASSWORD
