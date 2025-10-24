from libc.stdio cimport printf


cdef main():
    printf(b"%s\n", b"Hello, World!")


if __name__ == "__main__":
    main()
