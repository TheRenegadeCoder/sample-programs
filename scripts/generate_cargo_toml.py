from pathlib import Path


CARGO_TOML = """\
[package]
name = "sample-programs"
version = "0.1.0"
edition = "2024"
"""
SCRIPTS_FORMAT = """
[[bin]]
name = "{name}"
path = "{path}"
"""

def main():
    cargo_toml = CARGO_TOML
    for path in Path("archive/r/rust").glob("*.rs"):
        cargo_toml += SCRIPTS_FORMAT.format(name=path.stem, path=path)

    Path("Cargo.toml").write_text(cargo_toml, encoding="utf-8")


if __name__ == "__main__":
    main()
