from pathlib import PosixPath
certdir = PosixPath('~/.stepbystep/cert').expanduser()
cafile = certdir.joinpath('ca.pem')
certfile = certdir.joinpath('server.pem')
keyfile = certdir.joinpath('server-key.pem')