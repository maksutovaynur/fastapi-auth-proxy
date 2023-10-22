import secrets
from typing import Annotated

import httpx
from fastapi import FastAPI, Request, Response, Depends, HTTPException, WebSocket
from fastapi.security import HTTPBasic, HTTPBasicCredentials
from starlette import status

from fastapi_auth_proxy.env import ACCESS_USERNAME, ACCESS_PASSWORD, REDIRECT_URL

security = HTTPBasic()


def check_user(credentials: Annotated[HTTPBasicCredentials, Depends(security)]) -> dict:
    print(f'User trying to log in with creds: "{credentials.username}"')
    if credentials.username == ACCESS_USERNAME:
        if secrets.compare_digest(credentials.password.encode('utf-8'), ACCESS_PASSWORD.encode('utf-8')):
            return {'username': credentials.username}

    raise HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Incorrect login or password",
        headers={"WWW-Authenticate": "Basic"},
    )


UserRequired = Annotated[dict, Depends(check_user)]


app = FastAPI(docs_url='/fastapi-proxy-docs')


@app.websocket("/{path:path}")
async def proxy_ws(websocket: WebSocket):
    pass


@app.get("/{path:path}")
async def proxy_get(request: Request, path: str, user: UserRequired):
    url = f"{REDIRECT_URL}/{path}"
    headers = {**request.headers}
    headers['accept-encoding'] = 'deflate'
    async with httpx.AsyncClient(timeout=120) as client:
        response = await client.get(url, headers=headers, params=request.query_params)
    print(f'GET "{url}", response length: {len(response.content) if response.content else 0}')
    return Response(
        content=response.content,
        status_code=response.status_code,
        headers=response.headers,
    )


@app.post("/{path:path}")
async def proxy_post(request: Request, path: str, user: UserRequired):
    url = f"{REDIRECT_URL}/{path}"
    async with httpx.AsyncClient(timeout=120) as client:
        response = await client.post(url, content=await request.body(), headers=request.headers)
    print(f'POST "{url}"')
    return Response(
        content=response.content,
        status_code=response.status_code,
        headers=response.headers
    )
