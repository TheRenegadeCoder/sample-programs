#!/usr/bin/julia

function SelectionSort(arr)
    l = length(arr)
    sorted_list = []
    for i = 1:l
        m = minimum(arr)
        push!(sorted_list,m)
        deleteat!(arr, findfirst(x->x==m,arr))
    end
    return sorted_list
end

function error()
    println("Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\"")
end

function HandleInput(inp)

    a = split(inp,",")
    a = map(x->split(x," "),a)
    a = map(x->last(x),a)
    numbers = map(x->parse(Int,x),a)
    if length(numbers) == 1
        error()
        exit()
    end
    return numbers
    
end

function PrintOutput(out)
    for i = 1:length(out)
        print(out[i])
        if i != length(out)
            print(", ")
        end
    end
    println()
end

try

    n = HandleInput(ARGS[1])
    sorted = SelectionSort(n)
    PrintOutput(sorted)

catch e
    error()
end


