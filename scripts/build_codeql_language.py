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


LANGUAGE_TABLE = {
    "c": {"dir_path": "archive/c/c", "extension": ".c", "func": build_c},
}

if __name__ == "__main__":
    main()
