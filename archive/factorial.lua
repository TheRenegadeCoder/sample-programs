function fact (n)
    if n == 0 then
        return 1
    else
        return n * fact(n-1)
    end
end
    
print("enter a number:")
a = io.read("*number")     
print(fact(a))
