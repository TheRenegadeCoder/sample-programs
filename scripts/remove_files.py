import os
import sys
from contextlib import suppress


def main():
    for path in sys.argv[1:]:
        with suppress(OSError):
            os.remove(path)


if __name__ == "__main__":
    main()
