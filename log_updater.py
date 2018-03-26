TEMPLATE = """
## Day {0}: March {1}, 2018

**Today's Progress**: Implemented Hello World in {2}

**Link(s) to work**
1. [Hello World in {2}](https://therenegadecoder.com/code/python/hello-world-in-{3}/)
"""


def main():
    day = input('Day out of 100: ')
    date = input('Day of Month: ')
    language = input('Language: ')
    log = open('log.md', 'a')
    log.write(TEMPLATE.format(day, date, language, language.lower()))


if __name__ == '__main__':
    main()
