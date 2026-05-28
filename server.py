from fastapi import FastAPI
import ssl
import config as cfg
from uvicorn.config import Config
from collections.abc import Callable

app = FastAPI()

@app.get("/")
async def index():
    return {"message": "Hello StepByStep!"}


def ssl_context_factory(_config: Config, default_ssl_context_factory: Callable[[], ssl.SSLContext]) -> ssl.SSLContext:
    # https://docs.python.org/3/library/ssl.html#security-considerations
    # https://uvicorn.dev/deployment/#customizing-the-ssl-context
    context = ssl.create_default_context(ssl.Purpose.CLIENT_AUTH)
    context.minimum_version = ssl.TLSVersion.TLSv1_3
    context.verify_mode = ssl.CERT_REQUIRED
    context.load_cert_chain(certfile=str(cfg.certfile), keyfile=str(cfg.keyfile))
    context.load_verify_locations(cfg.cafile)
    return context

def run(host: str = "127.0.0.1", port: int = 8000):
    import uvicorn
    uvicorn.run(app, host=host, port=port,
                ssl_context_factory=ssl_context_factory
            )
