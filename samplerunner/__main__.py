import sys
import argparse

from samplerunner.run import run
from samplerunner.test import test


def main():
    parser = argparse.ArgumentParser(
        prog='samplerunner',
        usage='''usage: samplerunner [-h] COMMAND

Commands:
  run         Run a specified archive item or group of archive items. Use `samplerunner run --help` for more information.
  test        Run unit tests. Use `samplerunner test --help` for more information.

optional arguments:
  -h, --help  show this help message and exit
'''
    )
    parser.add_argument(
        'command',
        type=str,
        help='Subcommand to run',
        choices=['run', 'test']
    )
    args = parser.parse_args(sys.argv[1:2])
    commands = {
        'run': parse_run,
        'test': parse_test,
    }
    commands[args.command]()


def parse_run():
    parser = argparse.ArgumentParser(
        prog='samplerunner',
        description='Run a specified archive item or group of archive items. This command can run a language, a project'
                    'or a source. Only one option may be specified.',
    )
    args = _parse_args_for_verb(parser)
    run(args)


def parse_test():
    parser = argparse.ArgumentParser(
        prog='samplerunner',
        description='Run tests for a specified archive item or group of archive items. '
                    'This command can test a language, a project or a source. Only one option may be specified.'
    )
    args = _parse_args_for_verb(parser)
    test(args)


def _parse_args_for_verb(parser):
    group = parser.add_mutually_exclusive_group()
    group.add_argument(
        '-s', '--source',
        metavar='SOURCE.EXT',
        type=str,
        help='source filename (not path) to run',
    )
    group.add_argument(
        '-p', '--project',
        metavar='PROJECT',
        type=str,
        help='project to run',
    )
    group.add_argument(
        '-l', '--language',
        metavar='LANGUAGE',
        type=str,
        help='language to run',
    )
    args = parser.parse_args(sys.argv[2:])
    return args


if __name__ == '__main__':
    main()
