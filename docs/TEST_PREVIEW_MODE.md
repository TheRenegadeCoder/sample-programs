# Test Preview Mode

## Overview

The `--list-only` flag allows you to preview which tests would run without actually executing them. This is particularly useful for:

- **Debugging test selection logic** - See exactly which tests match your criteria
- **Verifying CI/CD changes** - Check test coverage before committing
- **Understanding batch distribution** - See how tests are divided across parallel batches
- **Saving time and resources** - Avoid downloading Docker images just to check what would run

## Usage

### Basic Syntax

```bash
python scripts/run_tests.py --num-batches <N> --list-only [files...]
```

### Examples

#### Preview all tests
```bash
python scripts/run_tests.py --num-batches 6 --list-only
```

**Output:**
```
=== Previewing full test suite ===

Would run all batches (num_batches=6).
```

#### Preview tests for specific files
```bash
python scripts/run_tests.py --num-batches 6 --list-only archive/p/python/fizz_buzz.py
```

**Output:**
```
=== Previewing tests for archive/p/python/fizz_buzz.py ===

python: fizz-buzz

Batch 1: python
```

#### Preview tests for multiple languages
```bash
python scripts/run_tests.py --num-batches 6 --list-only archive/*/*/hello-world.*
```

**Output:**
```
=== Previewing tests for [files...] ===

javascript: hello-world
python: hello-world
ruby: hello-world
rust: hello-world

Batch 1: javascript, python
Batch 2: ruby, rust
```

#### Preview after modifying testinfo.yml
```bash
python scripts/run_tests.py --num-batches 6 --list-only archive/p/python/testinfo.yml
```

**Output:**
```
=== Previewing tests for python ===

Batch 1: python
```

## How It Works

The `--list-only` flag modifies the test runner behavior at three levels:

### 1. Full Test Suite
When configuration files change, the preview shows:
- Total number of batches that would run
- Confirmation that all languages would be tested

### 2. Language-Level Tests
When `testinfo.yml` files change, the preview shows:
- Which languages are affected
- How languages are distributed across batches
- No Docker images are downloaded

### 3. Sample Program Tests
When individual program files change, the preview shows:
- Which specific programs would be tested
- Language and project mapping
- Batch distribution for parallel execution

## Benefits

### 🚀 Performance
- **No Docker downloads** - Saves bandwidth and time
- **Instant feedback** - See results in seconds, not minutes
- **No container execution** - Preserves system resources

### 🔍 Debugging
- **Clear visibility** - See exactly what the test selector picks up
- **Batch inspection** - Understand parallel execution distribution
- **Selection validation** - Confirm your file patterns work as expected

### 💡 Development Workflow
```bash
# 1. Make changes to code
vim archive/p/python/hello_world.py

# 2. Preview what tests would run
python scripts/run_tests.py --num-batches 6 --list-only archive/p/python/hello_world.py

# 3. If preview looks good, run actual tests
python scripts/run_tests.py --num-batches 6 archive/p/python/hello_world.py
```

## Integration with CI/CD

You can use `--list-only` in your CI pipeline to generate test reports:

```yaml
# .github/workflows/preview-tests.yml
name: Preview Tests

on: [pull_request]

jobs:
  preview:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Preview affected tests
        run: |
          python scripts/run_tests.py --num-batches 6 --list-only $(git diff --name-only origin/main)
```

## Troubleshooting

### No tests selected
If you see "No sample programs selected", verify:
- File paths are correct and files exist
- Files are not just README.md (these are excluded)
- Languages have valid `testinfo.yml` configuration

### Empty batch preview
If batches appear empty:
- Check if languages are properly detected from file paths
- Verify the parent directory contains source files
- Ensure `testinfo.yml` exists for the language

## Technical Details

### Skip Operations
When `--list-only` is enabled:
- ✅ File path validation runs
- ✅ Language detection runs  
- ✅ Project mapping runs
- ✅ Batch distribution calculation runs
- ❌ Docker image downloads are skipped
- ❌ Container execution is skipped
- ❌ Test runs are skipped
- ❌ Image cleanup is skipped

### Exit Codes
- `0` - Successfully previewed (even if no tests selected)
- Non-zero exit codes are not used in preview mode

## Contributing

If you find issues with the preview mode or have suggestions for improvement, please:
1. Open an issue describing the problem
2. Include example commands and output
3. Mention the `--list-only` flag in the title

## See Also

- [Main Testing Documentation](../README.md)
- [Glotter Documentation](https://github.com/rzuckerman/glotter)
- [Contributing Guide](../CONTRIBUTING.md)
