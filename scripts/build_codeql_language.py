import argparse
import subprocess
from dataclasses import dataclass
from pathlib import Path
from typing import Callable, List


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("language", help="language to build")
    parser.add_argument("config_file", help="configuration file")
    parsed_args = parser.parse_args()
    language_entry = LANGUAGE_TABLE[parsed_args.language]
    lines = Path(parsed_args.config_file).splitlines()[1:]
    for line in lines:
        line = line.strip()[1:].strip()
        if line:
            for path in Path.glob(line):
                if path.suffix == language_entry.extension:
                    print(f"Building {path}")
                    command = language_entry.func(path)
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


@dataclass
class LanguageInfo:
    extension: str
    func: Callable[[Path], List[str]]


LANGUAGE_TABLE = {
    "c": LanguageInfo(extension=".c", func=build_c),
    "cpp": LanguageInfo(extension=".cpp", func=build_cpp),
    "c#": LanguageInfo(extension=".cs", func=build_c_sharp),
    "java": LanguageInfo(extension=".java", func=build_java),
    "kotlin": LanguageInfo(extension=".kt", func=build_kotlin),
    "swift": LanguageInfo(extension=".swift", func=build_swift),
}

if __name__ == "__main__":
    main()
