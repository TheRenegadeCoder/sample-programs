LOG_FILE = 'log.md'
TEMPLATE = """
## Day {0}: March {1}, 2018

**Today's Progress**: Implemented Hello World in {2}

**Link(s) to work**
1. [Hello World in {2}](https://therenegadecoder.com/code/python/hello-world-in-{3}/)
"""


def get_day():
    """
    Retrieves the last day from the log and increments it.

    :return: the current day
    """
    log = open(LOG_FILE, 'r')
    lines = log.readlines()
    day = 0
    for line in reversed(lines):
        if 'Day' in line:
            day = int(line.split()[2][:-1]) + 1
            break
    log.close()
    return day


def add_record(day, date, language):
    """
    Updates the log with a new record.

    :param day: the day of code
    :param date: the day of the month
    :param language: the programming language
    :return: nothing
    """
    log = open(LOG_FILE, 'a')
    log.write(TEMPLATE.format(day, date, language, language.lower()))
    log.close()


def main():
    date = input('Day of Month: ')
    language = input('Language: ')
    day = get_day()
    add_record(day, date, language)


if __name__ == '__main__':
    main()
