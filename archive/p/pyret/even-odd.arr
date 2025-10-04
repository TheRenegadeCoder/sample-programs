import cmdline-lib as CL

usage = "Usage: please input a number\n"
args = CL.command-line-arguments()
cases(Option) string-to-number(if args.length() > 1: args.get(1) else: "" end):
  | none => print(usage)
  | some(n) =>
    if not(num-is-integer(n)): print(usage)
    else if num-modulo(n, 2) == 0: print("Even\n")
    else: print("Odd\n")
    end
end
