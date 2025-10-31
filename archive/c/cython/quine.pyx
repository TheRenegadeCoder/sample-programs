from libc.stdio cimport printf

def main():
    cdef bytes s = b"""from libc.stdio cimport printf

def main():
    cdef bytes s = b%c%c%c%s%c%c%c
    printf(s, 34, 34, 34, s, 34, 34, 34)

if __name__ == "__main__":
    main()"""
    printf(s, 34, 34, 34, s, 34, 34, 34)

if __name__ == "__main__":
    main()
