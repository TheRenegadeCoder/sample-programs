import sys
import threading
from time import sleep


def arg_to_list(string):
    return [int(x.strip(" "), 10) for x in string.split(',')]


def sleep_sort(i):
    sleep(i)
    print(i)


def main():
    array = arg_to_list(sys.argv[1])
    
    threads = []
    for i in array:
        arg_tuple = (i,)
        thread = threading.Thread(target=sleep_sort, args=arg_tuple)
        thread.start()
        threads.append(thread)
        
    for thread in threads:
        thread.join()

        
main()
