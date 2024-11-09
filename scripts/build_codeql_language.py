import argparse
import subprocess
from pathlib import Path


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("language", help="language_to_build")
    parsed_args = parser.parse_args()
    language_entry = LANGUAGE_TABLE[parsed_args.language]
    for path in Path(language_entry["dir_path"]).iterdir():
        if path.suffix == language_entry["extension"]:
            print(f"Building {path}")
            language_entry["func"](path)


def build_c(path: Path):
    subprocess.run(["gcc", "-o", str(path.stem), str(path.name)], cwd=path.parent, check=True)


def build_cpp(path: Path):
    subprocess.run(["g++", "-o", str(path.stem), str(path.name)], cwd=path.parent, check=True)


def build_c_sharp(path: Path):
    subprocess.run(
        ["mcs", "-reference:System.Numerics", str(path.name)], cwd=path.parent, check=True
    )


LANGUAGE_TABLE = {
    "c": {"dir_path": "archive/c/c", "extension": ".c", "func": build_c},
    "cpp": {"dir_path": "archive/c/c-plus-plus", "extension": ".cpp", "func": build_cpp},
    "c#": {"dir_path": "archive/c/c-sharp", "extension": ".cs", "func": build_c_sharp},
}

if __name__ == "__main__":
    main()
