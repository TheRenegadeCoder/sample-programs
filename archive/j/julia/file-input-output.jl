function readfile(file)
    open(file) do f
        read(f, String)
    end
end

function writefile(file, text)
    open(file, "w") do f
        write(f, text)
    end
end

function main()
    writefile("output.txt", "Hello, world!")
    println(readfile("output.txt"))
end

main()