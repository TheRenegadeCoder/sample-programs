import base64
import binascii
import sys
from typing import NoReturn


def usage() -> NoReturn:
    print("Usage: please provide a mode and a string to encode/decode")
    sys.exit(1)


def base64_encode(s: str) -> str:
    return base64.b64encode(s.encode("ascii")).decode("ascii")


def base64_decode(s: str) -> str:
    return base64.b64decode(s.encode("ascii"), validate=True).decode("ascii")


def main() -> None | NoReturn:
    if len(sys.argv) < 3 or not sys.argv[2]:
        usage()

    mode = sys.argv[1]
    s = sys.argv[2]
    if mode == "encode":
        result = base64_encode(s)
    elif mode == "decode":
        try:
            result = base64_decode(s)
        except binascii.Error:
            usage()
    else:
        usage()

    print(result)


if __name__ == "__main__":
    main()
