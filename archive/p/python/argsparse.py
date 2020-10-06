import argparse

parser = argparse.ArgumentParser()

parser.add_argument("--first")
parser.add_argument('--last')

parser.add_argument("--echo", action='store_true')
parser.add_argument("--format", action='store_true')

parser.set_defaults(
    first="Will",
    last="Robinson",
    echo=False,
    format=False
)

args = parser.parse_args()

if args.echo:
    print(f"Got name {args.first} {args.last}")

if args.format:
    name = f"{args.first} {args.last}".title()
else:
    name = f"{args.first} {args.last}"

print(f"Danger, {name}.")
