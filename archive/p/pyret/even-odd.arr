import cmdline-lib as CL

fun even_odd(n):
    if num-modulo(n, 2) == 0:
        "Even"
    else:
        "Odd"
    end
end

usage = "Usage: please input a number\n"
args = CL.command-line-arguments()
if args.length() < 2:
    print(usage)
else:
    cases(Option) string-to-number(args.get(1)):
        | none => print(usage)
        | some(n) => print(even_odd(n) + "\n")
    end
end
