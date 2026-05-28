# mTLS (mutual TLS) experiment simple API Server

## Generates Certificate (root CA, Server and Clinet)

```bash
make gencert
```

## Activate Python Virtual Environment

```bash
uv venv
source .venv/bin/activate
```

## Run API Server

```bash
uv run main.py 8443
```

### Client

```bash
curl https://localhost:8443 \
--cacert ~/.stepbystep/cert/ca.pem \
--cert ~/.stepbystep/cert/client.pem \
--key ~/.stepbystep/cert/client-key.pem \
-i
```

```html
HTTP/1.1 200 OK
date: Thu, 28 May 2026 09:17:48 GMT
server: uvicorn
content-length: 31
content-type: application/json

{"message":"Hello StepByStep!"}
```

```bash
curl https://localhost:8443 \
--cacert ~/.stepbystep/cert/ca.pem \
--cert ~/.stepbystep/cert/client.pem \
--key ~/.stepbystep/cert/client-key.pem \
-v -i -w "\n\n"
```

![mTLS communication](./resources/mtls_communication.webp)
