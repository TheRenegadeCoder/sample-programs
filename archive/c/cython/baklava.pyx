from libc.stdio cimport printf


cdef main():
    cdef int n
    cdef int num_spaces
    cdef int num_stars
    cdef bytes buffer
    for n in range(-10, 11):
        num_spaces = abs(n)
        num_stars = 21 - 2 * num_spaces
        buffer = b" " * num_spaces + b"*" * num_stars
        printf(b"%s\n", buffer)


if __name__ == "__main__":
    main()
