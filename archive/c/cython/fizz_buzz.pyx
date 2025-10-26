from libc.stdio cimport printf


cdef main():
    cdef int n
    cdef bytes buffer
    for n in range(1, 101):
        buffer = b""
        buffer += b"Fizz" if n % 3 == 0 else b""
        buffer += b"Buzz" if n % 5 == 0 else b""
        buffer += bytes(str(n).encode("ascii")) if not buffer else b""
        printf("%s\n", buffer)

if __name__ == "__main__":
    main()
