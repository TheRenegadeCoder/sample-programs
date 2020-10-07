# Lru documentation at https://docs.python.org/3/library/functools.html#functools.lru_cache

from functools import lru_cache
import time 

# Fibonacci function with Lru cache
@lru_cache(maxsize=None)
def fib_cache(n):
    if n < 2:
        return n
    return fib_cache(n-1) + fib_cache(n-2)

start_time = time.time()
print([fib_cache(n) for n in range(32)])

end_time = time.time() 
print("Execution time with Lru cache: ", end_time - start_time)
print()
  
# Fibonacci function without Lru cache
def fib(n):
    if n < 2:
        return n
    return fib(n-1) + fib(n-2)

start_time = time.time()
print([fib(n) for n in range(32)])

end_time = time.time() 
print("Execution time without Lru cache: ", end_time - start_time)     
