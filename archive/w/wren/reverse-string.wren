import "os" for Process

var args = Process.arguments

if (args.count < 1) {
  args.add("")
}

var rev = ""

for (c in args[0]) {
  rev = c + rev
}

System.print(rev)
