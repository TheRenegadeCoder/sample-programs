import error as ERR
import cmdline-lib as CL

fun usage():
  block:
    print("Usage: please input a number\n")
    raise(ERR.exit-quiet(0))
  end
end

args = CL.command-line-arguments()
when args.length() < 2:
  usage()
end

cases(Option) string-to-number(args.get(1)):
  | none => usage()
  | some(n) =>
      if num-modulo(n, 2) == 0: print("Even\n")
      else: print("Odd\n")
      end
end
