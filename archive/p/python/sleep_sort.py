import sys
import threading
from time import sleep


def arg_to_list(string):
    return [int(x.strip(" "), 10) for x in string.split(',')]


def sleep_sort(i, output):
    sleep(i)
    output.append(i)


def main():
    array = arg_to_list(sys.argv[1])
    
    threads = []
    output = []
    for i in array:
        arg_tuple = (i, output)
        thread = threading.Thread(target=sleep_sort, args=arg_tuple)
        thread.start()
        threads.append(thread)
        
    for thread in threads:
        thread.join()
        
    print(output)

main()
