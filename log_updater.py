TEMPLATE = """## Day {0}: March {1}, 2018

**Today's Progress**: Implemented Hello World in {2}

**Link(s) to work**
1. [Hello World in {2}](https://therenegadecoder.com/code/python/hello-world-in-{2}/)
"""


def main():
    print(TEMPLATE.format(5, 18, 'Python'))


if __name__ == '__main__':
    main()
