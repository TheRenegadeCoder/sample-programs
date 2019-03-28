def clean_list(string):
    """
    Strip optional characters from list for sake of comparing in tests
    :param string: the list to clean represented as a string
    :return: the clean list a as a string
    """
    return string.replace('[', '').replace(']', '').strip()
