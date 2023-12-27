import cmdline-lib as CL

args = CL.command-line-arguments()
cases(Option) string-to-number(if args.length() > 1: args.get(1) else: "" end):
  | none => print("Usage: please input a number\n")
  | some(n) =>
      if num-modulo(n, 2) == 0: print("Even\n")
      else: print("Odd\n")
      end
end
