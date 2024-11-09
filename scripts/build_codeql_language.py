import argparse
import subprocess
from pathlib import Path
from typing import List


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("language", help="language_to_build")
    parsed_args = parser.parse_args()
    language_entry = LANGUAGE_TABLE[parsed_args.language]
    for path in Path(language_entry["dir_path"]).iterdir():
        if path.suffix == language_entry["extension"]:
            print(f"Building {path}")
            command = language_entry["func"](path)
            subprocess.run(command, cwd=str(path.parent), check=True)


def build_c(path: Path) -> List[str]:
    return ["gcc", "-o", str(path.stem), str(path.name)]


def build_cpp(path: Path) -> List[str]:
    return ["g++", "-o", str(path.stem), str(path.name)]


def build_c_sharp(path: Path) -> List[str]:
    return ["mcs", "-reference:System.Numerics", str(path.name)]


def build_java(path: Path) -> List[str]:
    return ["javac", str(path.name)]


LANGUAGE_TABLE = {
    "c": {"dir_path": "archive/c/c", "extension": ".c", "func": build_c},
    "cpp": {"dir_path": "archive/c/c-plus-plus", "extension": ".cpp", "func": build_cpp},
    "c#": {"dir_path": "archive/c/c-sharp", "extension": ".cs", "func": build_c_sharp},
    "java": {"dir_path": "archive/j/java", "extension": ".java", "func": build_java},
}

if __name__ == "__main__":
    main()
