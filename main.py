import argparse

import server


def main():
    parser = argparse.ArgumentParser("https server")
    parser.add_argument("port", help="Run HTTPS server listening on port assigned.", type=int)
    args = parser.parse_args()

    print(f'Serving StepByStep HTTPS on port {args.port}...')

    server.run("127.0.0.1", args.port)

if __name__ == "__main__":
    main()
