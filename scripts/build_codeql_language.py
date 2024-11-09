import argparse
import subprocess
from dataclasses import dataclass
from pathlib import Path
from typing import Callable, List


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("language", help="language_to_build")
    parsed_args = parser.parse_args()
    language_entry = LANGUAGE_TABLE[parsed_args.language]
    for path in Path(language_entry.dir_path).iterdir():
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
    return ["javac", str(path.name)]


def build_kotlin(path: Path) -> List[str]:
    return ["kotlinc", str(path.name), "-include-runtime", "-d", f"{path.stem}.jar"]


@dataclass
class LanguageInfo:
    dir_path: str
    extension: str
    func: Callable[[Path], List[str]]


LANGUAGE_TABLE = {
    "c": LanguageInfo(dir_path="archive/c/c", extension=".c", func=build_c),
    "cpp": LanguageInfo(dir_path="archive/c/c-plus-plus", extension=".cpp", func=build_cpp),
    "c#": LanguageInfo(dir_path="archive/c/c-sharp", extension=".cs", func=build_c_sharp),
    "java": LanguageInfo(dir_path="archive/j/java", extension=".java", func=build_java),
    "kotlin": LanguageInfo(dir_path="archive/k/kotlin", extension=".kt", func=build_kotlin),
}

if __name__ == "__main__":
    main()
