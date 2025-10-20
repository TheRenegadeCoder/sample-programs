#!/usr/bin/env python3
"""
Test Coverage Analyzer for Sample Programs

This script analyzes the test coverage across all programming languages
in the sample-programs repository. It provides insights into:
- Which languages have the most/least sample programs
- Which algorithms are implemented in which languages
- Coverage gaps and opportunities for contributions

Usage:
    python scripts/analyze_coverage.py [--format json|table|markdown]
"""

import argparse
import json
import sys
from collections import defaultdict
from pathlib import Path
from typing import Dict, List, Set, Tuple


def get_archive_root() -> Path:
    """Get the archive directory path."""
    return Path(__file__).parent.parent / "archive"


def scan_languages() -> Dict[str, Set[str]]:
    """
    Scan all languages and their implemented programs.
    
    Returns:
        Dict mapping language name to set of program names
    """
    archive = get_archive_root()
    language_programs = defaultdict(set)
    
    for letter_dir in sorted(archive.iterdir()):
        if not letter_dir.is_dir() or letter_dir.name.startswith('.'):
            continue
            
        for lang_dir in sorted(letter_dir.iterdir()):
            if not lang_dir.is_dir() or lang_dir.name.startswith('.'):
                continue
                
            language = lang_dir.name
            
            # Find all program files (excluding README, testinfo.yml)
            for file_path in lang_dir.iterdir():
                if file_path.is_file() and file_path.name not in ['README.md', 'testinfo.yml']:
                    # Extract program name (remove extension and convert to readable form)
                    program_name = file_path.stem.replace('_', '-').replace(' ', '-')
                    language_programs[language].add(program_name)
    
    return dict(language_programs)


def get_all_programs(language_programs: Dict[str, Set[str]]) -> Set[str]:
    """Get set of all unique programs across all languages."""
    all_programs = set()
    for programs in language_programs.values():
        all_programs.update(programs)
    return all_programs


def calculate_statistics(language_programs: Dict[str, Set[str]]) -> Dict:
    """Calculate various statistics about coverage."""
    all_programs = get_all_programs(language_programs)
    
    stats = {
        'total_languages': len(language_programs),
        'total_programs': len(all_programs),
        'total_implementations': sum(len(progs) for progs in language_programs.values()),
        'avg_programs_per_language': sum(len(progs) for progs in language_programs.values()) / len(language_programs),
        'most_implemented': [],
        'least_implemented': [],
        'language_rankings': [],
        'program_rankings': [],
    }
    
    # Program implementation counts
    program_counts = defaultdict(int)
    for programs in language_programs.values():
        for program in programs:
            program_counts[program] += 1
    
    # Sort programs by implementation count
    sorted_programs = sorted(program_counts.items(), key=lambda x: x[1], reverse=True)
    stats['most_implemented'] = sorted_programs[:10]
    stats['least_implemented'] = sorted_programs[-10:]
    
    # Language rankings by number of programs
    language_rankings = sorted(
        [(lang, len(progs)) for lang, progs in language_programs.items()],
        key=lambda x: x[1],
        reverse=True
    )
    stats['language_rankings'] = language_rankings
    stats['program_rankings'] = sorted_programs
    
    return stats


def format_table(language_programs: Dict[str, Set[str]], stats: Dict) -> str:
    """Format output as a table."""
    output = []
    
    output.append("=" * 80)
    output.append("SAMPLE PROGRAMS COVERAGE ANALYSIS")
    output.append("=" * 80)
    output.append("")
    
    output.append("SUMMARY STATISTICS")
    output.append("-" * 80)
    output.append(f"Total Languages: {stats['total_languages']}")
    output.append(f"Total Unique Programs: {stats['total_programs']}")
    output.append(f"Total Implementations: {stats['total_implementations']}")
    output.append(f"Average Programs per Language: {stats['avg_programs_per_language']:.2f}")
    output.append("")
    
    output.append("TOP 10 MOST IMPLEMENTED PROGRAMS")
    output.append("-" * 80)
    output.append(f"{'Program':<40} {'Languages':<10} {'Coverage %':<10}")
    output.append("-" * 80)
    for program, count in stats['most_implemented']:
        coverage_pct = (count / stats['total_languages']) * 100
        output.append(f"{program:<40} {count:<10} {coverage_pct:>6.1f}%")
    output.append("")
    
    output.append("TOP 10 LANGUAGES BY PROGRAM COUNT")
    output.append("-" * 80)
    output.append(f"{'Language':<30} {'Programs':<10} {'Coverage %':<10}")
    output.append("-" * 80)
    for language, count in stats['language_rankings'][:10]:
        coverage_pct = (count / stats['total_programs']) * 100
        output.append(f"{language:<30} {count:<10} {coverage_pct:>6.1f}%")
    output.append("")
    
    output.append("BOTTOM 10 LANGUAGES BY PROGRAM COUNT")
    output.append("-" * 80)
    output.append(f"{'Language':<30} {'Programs':<10} {'Coverage %':<10}")
    output.append("-" * 80)
    for language, count in stats['language_rankings'][-10:]:
        coverage_pct = (count / stats['total_programs']) * 100
        output.append(f"{language:<30} {count:<10} {coverage_pct:>6.1f}%")
    output.append("")
    
    return "\n".join(output)


def format_markdown(language_programs: Dict[str, Set[str]], stats: Dict) -> str:
    """Format output as Markdown."""
    output = []
    
    output.append("# Sample Programs Coverage Analysis")
    output.append("")
    
    output.append("## Summary Statistics")
    output.append("")
    output.append(f"- **Total Languages**: {stats['total_languages']}")
    output.append(f"- **Total Unique Programs**: {stats['total_programs']}")
    output.append(f"- **Total Implementations**: {stats['total_implementations']}")
    output.append(f"- **Average Programs per Language**: {stats['avg_programs_per_language']:.2f}")
    output.append("")
    
    output.append("## Top 10 Most Implemented Programs")
    output.append("")
    output.append("| Program | Languages | Coverage % |")
    output.append("|---------|-----------|------------|")
    for program, count in stats['most_implemented']:
        coverage_pct = (count / stats['total_languages']) * 100
        output.append(f"| {program} | {count} | {coverage_pct:.1f}% |")
    output.append("")
    
    output.append("## Top 10 Languages by Program Count")
    output.append("")
    output.append("| Language | Programs | Coverage % |")
    output.append("|----------|----------|------------|")
    for language, count in stats['language_rankings'][:10]:
        coverage_pct = (count / stats['total_programs']) * 100
        output.append(f"| {language} | {count} | {coverage_pct:.1f}% |")
    output.append("")
    
    output.append("## Languages Needing More Programs")
    output.append("")
    output.append("These languages have the fewest implementations and could use contributions:")
    output.append("")
    output.append("| Language | Programs | Coverage % |")
    output.append("|----------|----------|------------|")
    for language, count in stats['language_rankings'][-10:]:
        coverage_pct = (count / stats['total_programs']) * 100
        output.append(f"| {language} | {count} | {coverage_pct:.1f}% |")
    output.append("")
    
    return "\n".join(output)


def format_json(language_programs: Dict[str, Set[str]], stats: Dict) -> str:
    """Format output as JSON."""
    # Convert sets to lists for JSON serialization
    json_data = {
        'statistics': {
            'total_languages': stats['total_languages'],
            'total_programs': stats['total_programs'],
            'total_implementations': stats['total_implementations'],
            'avg_programs_per_language': stats['avg_programs_per_language'],
        },
        'languages': {
            lang: sorted(list(progs)) 
            for lang, progs in language_programs.items()
        },
        'most_implemented_programs': [
            {'program': prog, 'count': count, 'coverage_pct': (count / stats['total_languages']) * 100}
            for prog, count in stats['most_implemented']
        ],
        'language_rankings': [
            {'language': lang, 'count': count, 'coverage_pct': (count / stats['total_programs']) * 100}
            for lang, count in stats['language_rankings']
        ],
    }
    
    return json.dumps(json_data, indent=2)


def find_coverage_gaps(language_programs: Dict[str, Set[str]]) -> List[Tuple[str, List[str]]]:
    """
    Find programs that are missing in specific languages.
    
    Returns list of (language, missing_programs) tuples for languages
    that are missing common programs.
    """
    all_programs = get_all_programs(language_programs)
    
    # Define "common" as programs implemented in at least 50% of languages
    program_counts = defaultdict(int)
    for programs in language_programs.values():
        for program in programs:
            program_counts[program] += 1
    
    threshold = len(language_programs) * 0.5
    common_programs = {prog for prog, count in program_counts.items() if count >= threshold}
    
    gaps = []
    for language, programs in language_programs.items():
        missing = sorted(common_programs - programs)
        if missing:
            gaps.append((language, missing))
    
    return sorted(gaps, key=lambda x: len(x[1]), reverse=True)


def main():
    """Main entry point."""
    parser = argparse.ArgumentParser(
        description="Analyze test coverage across sample programs"
    )
    parser.add_argument(
        '--format',
        choices=['table', 'markdown', 'json'],
        default='table',
        help='Output format (default: table)'
    )
    parser.add_argument(
        '--show-gaps',
        action='store_true',
        help='Show coverage gaps (missing common programs per language)'
    )
    
    args = parser.parse_args()
    
    # Scan repository
    language_programs = scan_languages()
    
    if not language_programs:
        print("Error: No languages found in archive/", file=sys.stderr)
        sys.exit(1)
    
    # Calculate statistics
    stats = calculate_statistics(language_programs)
    
    # Format and print output
    if args.format == 'json':
        print(format_json(language_programs, stats))
    elif args.format == 'markdown':
        print(format_markdown(language_programs, stats))
    else:
        print(format_table(language_programs, stats))
    
    # Show coverage gaps if requested
    if args.show_gaps:
        gaps = find_coverage_gaps(language_programs)
        print("\nCOVERAGE GAPS (Languages missing common programs)")
        print("=" * 80)
        for language, missing in gaps[:10]:  # Top 10
            print(f"\n{language} ({len(missing)} missing):")
            print("  " + ", ".join(missing[:5]))
            if len(missing) > 5:
                print(f"  ... and {len(missing) - 5} more")


if __name__ == '__main__':
    main()
