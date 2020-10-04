import sys
import logging


def duplicate_counter(text):
    char_dict = {}  # Dictionary where we store the characters and their occurrence amount
    for i in text:
        if text.count(i) > 1 and i not in char_dict:  # If i occurs more than once and hasn't already been done
            char_dict.update({i:text.count(i)})  # Add the key and value to char_dict{}
    return char_dict


def main():
    try:
        user_input = input("Text input: ")
        for char, occurrences in duplicate_counter(user_input).items():  # Iterate through user_input's letters and their respective occurrence amount
            print("Characters: {}, Occurrences: {}".format(char, occurrences))  # Print it to console, with easy to read formatting
    except Exception as e:
        logging.exception(e)  # Log any exceptions


if __name__ == "__main__":
    main()