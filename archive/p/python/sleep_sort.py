import sys
import _thread
from time import sleep


def arg_to_list(string):
    return [int(x.strip(" "), 10) for x in string.split(',')]


array = arg_to_list(sys.argv[1])


def sleep_sort(i):
    sleep(i)
    print(i)


for i in array:
    arg_tuple = (i,)
    _thread.start_new_thread(sleep_sort, arg_tuple)
