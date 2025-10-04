import "os" for Process

var args = Process.arguments

if (args.count < 1 || args[0].count < 1) {
  System.print("Usage: please provide a string")
  Fiber.suspend()
}

var s = ""

for (c in args[0]) {
  if (c != " " && c != "\n" && c != "\t" && c != "\r" && c != "\f") {
    s = s + c
  }
}

System.print(s)
