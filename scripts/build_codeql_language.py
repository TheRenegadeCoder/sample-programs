import argparse
import subprocess
from pathlib import Path
from typing import Callable, Dict, List


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("language", help="language to build")
    parser.add_argument("files_changed", nargs="*", help="files that have changed")
    parsed_args = parser.parse_args()
    command_func = COMMANDS[parsed_args.language]
    for changed_file in parsed_args.files_changed:
        path = Path(changed_file)
        print(f"Building {path}")
        command = command_func(path)
        subprocess.run(command, cwd=path.parent, check=True)


def build_c(path: Path) -> List[str]:
    return ["gcc", "-o", path.stem, path.name]


def build_cpp(path: Path) -> List[str]:
    return ["g++", "-o", path.stem, path.name]


def build_c_sharp(path: Path) -> List[str]:
    return ["mcs", "-reference:System.Numerics", path.name]


def build_java(path: Path) -> List[str]:
    return ["javac", path.name]


def build_kotlin(path: Path) -> List[str]:
    return ["kotlinc", path.name, "-include-runtime", "-d", f"{path.stem}.jar"]


def build_swift(path: Path) -> List[str]:
    return ["swiftc", "-o", path.stem, path.name]


COMMANDS: Dict[str, Callable[[Path], List[str]]] = {
    "c": build_c,
    "cpp": build_cpp,
    "c#": build_c_sharp,
    "java": build_java,
    "kotlin": build_kotlin,
    "swift": build_swift,
}

if __name__ == "__main__":
    main()
