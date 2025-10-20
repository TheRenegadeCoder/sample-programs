# Contributing Guide - Test Preview Mode

Thank you for your interest in improving the Sample Programs repository! This guide will help you understand and contribute to the test preview functionality.

## Quick Start

### Testing Your Changes

Before submitting a PR, always test your changes with the preview mode:

```bash
# Preview what tests would run for your changes
python scripts/run_tests.py --num-batches 6 --list-only path/to/your/changed/files

# If preview looks good, run actual tests
python scripts/run_tests.py --num-batches 6 path/to/your/changed/files
```

## Development Workflow

### 1. Setup Development Environment

```bash
# Fork and clone the repository
git clone https://github.com/YOUR_USERNAME/sample-programs.git
cd sample-programs

# Create a feature branch
git checkout -b feature/your-improvement

# Install dependencies
poetry install
```

### 2. Make Your Changes

Edit files in the repository:
- Add new sample programs in `archive/{letter}/{language}/`
- Update test configurations in `testinfo.yml` files
- Improve scripts in `scripts/` directory

### 3. Preview Impact

Use the preview mode to see what your changes affect:

```bash
# Check which tests your changes trigger
git diff --name-only main | xargs python scripts/run_tests.py --num-batches 6 --list-only
```

### 4. Run Actual Tests

Once preview confirms correct test selection:

```bash
# Run tests for changed files
git diff --name-only main | xargs python scripts/run_tests.py --num-batches 6
```

### 5. Commit and Push

```bash
git add .
git commit -m "Brief description of your changes"
git push origin feature/your-improvement
```

### 6. Create Pull Request

1. Go to your fork on GitHub
2. Click "Compare & pull request"
3. Fill in the PR template
4. Submit for review

## Common Contribution Patterns

### Adding a New Language

```bash
# 1. Create language directory
mkdir -p archive/{letter}/{language-name}

# 2. Add testinfo.yml
cat > archive/{letter}/{language-name}/testinfo.yml << EOF
folder:
  extension: ".ext"
  naming: "hyphen"  # or "underscore", "camel", "pascal"

container:
  image: "language-image"
  tag: "version"
  cmd: "command {{ source.name }}{{ source.extension }}"
EOF

# 3. Add at least hello-world program
# 4. Preview tests
python scripts/run_tests.py --num-batches 6 --list-only archive/{letter}/{language-name}/

# 5. Run tests
python scripts/run_tests.py --num-batches 6 archive/{letter}/{language-name}/
```

### Adding a New Program to Existing Language

```bash
# 1. Create program file
vim archive/{letter}/{language}/program-name.ext

# 2. Preview impact
python scripts/run_tests.py --num-batches 6 --list-only archive/{letter}/{language}/program-name.ext

# 3. Run tests
python scripts/run_tests.py --num-batches 6 archive/{letter}/{language}/program-name.ext
```

### Updating Test Configuration

```bash
# 1. Edit testinfo.yml
vim archive/{letter}/{language}/testinfo.yml

# 2. Preview which languages will be tested
python scripts/run_tests.py --num-batches 6 --list-only archive/{letter}/{language}/testinfo.yml

# 3. Run language tests
python scripts/run_tests.py --num-batches 6 archive/{letter}/{language}/testinfo.yml
```

## Testing Best Practices

### ✅ DO

- **Always preview before running tests**
  ```bash
  python scripts/run_tests.py --num-batches 6 --list-only [files...]
  ```

- **Test incrementally**
  - Test one language at a time when adding multiple programs
  - Preview helps catch issues early

- **Verify batch distribution**
  - Use `--list-only` to ensure tests are balanced across batches
  - Adjust `--num-batches` if needed for your workload

- **Check test selection logic**
  - Make sure only affected tests run
  - Use preview to verify test isolation

### ❌ DON'T

- **Don't skip preview on large changes**
  - Large PRs should always be previewed first
  - Saves CI/CD resources and time

- **Don't ignore preview output**
  - If preview shows unexpected tests, investigate why
  - Might indicate file naming or path issues

- **Don't mix unrelated changes**
  - Keep language additions separate from script changes
  - Makes review easier and tests more targeted

## Understanding Test Selection

### File Types and Their Test Impact

| File Changed | Tests Triggered | Preview Shows |
|--------------|----------------|---------------|
| `*.{lang-ext}` | That specific program in that language | Language + project |
| `testinfo.yml` | All programs in that language | All programs for language |
| `repo-config.yml` | All tests across all languages | Full suite |
| `scripts/run_tests.py` | All tests across all languages | Full suite |
| `README.md` | None (excluded) | Nothing |

### Example Preview Outputs

#### Single Program Change
```bash
$ python scripts/run_tests.py --num-batches 6 --list-only archive/p/python/hello_world.py
=== Previewing tests for archive/p/python/hello_world.py ===

python: hello-world

Batch 1: python
```

#### Multiple Programs, Same Language
```bash
$ python scripts/run_tests.py --num-batches 6 --list-only archive/p/python/*.py
=== Previewing tests for [40 files...] ===

python: baklava, binary-search, bubble-sort, capitalize, ...

Batch 1: python
```

#### Multiple Languages
```bash
$ python scripts/run_tests.py --num-batches 6 --list-only archive/p/python/hello_world.py archive/r/ruby/hello-world.rb
=== Previewing tests for [2 files...] ===

python: hello-world
ruby: hello-world

Batch 1: python
Batch 2: ruby
```

## Advanced Usage

### Analyzing Coverage

Use the coverage analyzer to find contribution opportunities:

```bash
# Show overall statistics
python scripts/analyze_coverage.py --format table

# Show coverage gaps (programs missing in languages)
python scripts/analyze_coverage.py --show-gaps

# Generate markdown report
python scripts/analyze_coverage.py --format markdown > coverage-report.md
```

### Batch Optimization

For large test runs, optimize batch count:

```bash
# Too many batches = overhead
python scripts/run_tests.py --num-batches 50 --list-only ...

# Sweet spot for most cases
python scripts/run_tests.py --num-batches 6 --list-only ...

# Minimum batching
python scripts/run_tests.py --num-batches 1 --list-only ...
```

### Parallel Testing

Combine preview with parallel execution:

```bash
# Preview parallel execution plan
python scripts/run_tests.py --num-batches 6 --parallel --list-only ...

# Execute in parallel
python scripts/run_tests.py --num-batches 6 --parallel ...
```

## Troubleshooting

### Preview Shows Nothing

**Problem**: `--list-only` says "No sample programs selected"

**Solutions**:
1. Check file paths are correct
2. Verify files exist: `ls -la path/to/file`
3. Make sure you're not only changing README.md
4. Confirm language directory has testinfo.yml

### Preview Shows Wrong Tests

**Problem**: Preview shows tests for unexpected languages

**Solutions**:
1. Check file naming conventions match testinfo.yml
2. Verify directory structure follows `archive/{letter}/{language}/`
3. Look for stray files that match patterns

### Batch Distribution Seems Off

**Problem**: All tests in one batch

**Solutions**:
1. Reduce `--num-batches` parameter
2. Check if you're only testing one language
3. Verify multiple languages are affected

## Getting Help

If you need assistance:

1. **Check existing documentation**
   - [TEST_PREVIEW_MODE.md](./TEST_PREVIEW_MODE.md)
   - [Main README](../README.md)

2. **Search existing issues**
   - https://github.com/TheRenegadeCoder/sample-programs/issues

3. **Ask in discussions**
   - https://github.com/TheRenegadeCoder/sample-programs/discussions

4. **Open a new issue**
   - Include preview output
   - Show commands you ran
   - Describe expected vs actual behavior

## Code of Conduct

Please be respectful and constructive in all interactions. This is a learning-focused project welcoming contributors of all skill levels.

## License

By contributing, you agree that your contributions will be licensed under the same license as the project (MIT License).

---

**Happy Contributing! 🚀**
