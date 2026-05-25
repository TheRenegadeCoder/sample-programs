from pathlib import Path

import yaml

C_SHARP_ARCHIVE_DIR = Path("archive/c/c-sharp")
C_SHARP_PROJECT_CONTENTS = """\
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <OutputType>Library</OutputType>
      <TargetFramework>net{version}</TargetFramework>
      <ImplicitUsings>enable</ImplicitUsings>
      <Nullable>enable</Nullable>
      <Deterministic>true</Deterministic>
  </PropertyGroup>
</Project>
"""



def main():
    testinfo = yaml.safe_load((C_SHARP_ARCHIVE_DIR / "testinfo.yml").read_text(encoding="utf-8"))
    tag = testinfo["container"]["tag"]
    project_contents = C_SHARP_PROJECT_CONTENTS.format(version=tag)
    (C_SHARP_ARCHIVE_DIR / "MyProj.csproj").write_text(project_contents, encoding="utf-8")


if __name__ == "__main__":
    main()
