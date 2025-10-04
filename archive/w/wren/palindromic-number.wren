import "os" for Process

var args = Process.arguments

if (args.count < 1 || args[0].count < 1) {
  System.print("Usage: please input a non-negative integer")
  Fiber.suspend()
}

var s = args[0]
var n = Num.fromString(s)

if (n == null || n < 0) {
  System.print("Usage: please input a non-negative integer")
  Fiber.suspend()
}

var a = ""

for (c in s) {
  a = c + a
  if (c == ".") {
    System.print("Usage: please input a non-negative integer")
    Fiber.suspend()
  }
}

System.print(a == s)
