def printCollatz(n): 
    while True: 
        print(n, end = ' ')
        #when reached 1 jump out of the loop
        if n == 1:
        	break
        # If n is odd  
        if n & 1: 
            n = 3 * n + 1
        # If even  
        else: 
            n = n // 2
printCollatz(int(input("Enter a natural number: "))) 