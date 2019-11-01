"""Run heapsort on a list a
    >>> a = [32,46,77,4344564,7322,3,46,7,32457,7542,4,667,54,]
    >>> heapsort(a)
    >>> print(a)
    [3, 4, 7, 32, 46, 46, 54, 77, 667, 7322, 7542, 32457, 4344564]
"""

def heapsort(a):

    heapify(a, len(a))
    end = len(a)-1
    while end > 0:
        a[end], a[0] = a[0], a[end]
        end -= 1
        sift_down(a, 0, end)

def heapify(a, count):
    start = int((count-2)/2)
    while start >= 0:
        sift_down(a, start, count-1)
        start -= 1

def sift_down(a, start, end):
    root = start
    while (root*2+1) <= end:
        child = root * 2 + 1
        swap = root
        if a[swap] < a[child]:
            swap = child
        if (child + 1) <= end and a[swap] < a[child+1]:
            swap = child+1
        if swap != root:
            a[root], a[swap] = a[swap], a[root]
            root = swap
        else:
            return

if __name__ == "__main__":
    import doctest
    doctest.testmod()