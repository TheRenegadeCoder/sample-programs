import "os" for Process

var args = Process.arguments

if (args.count < 1 || args[0].count < 1) {
  System.print("Usage: please input a non-negative integer")
  Fiber.suspend()
}

var n = Num.fromString(args[0])
if (n == null || n < 0) {
  System.print("Usage: please input a non-negative integer")
  Fiber.suspend()
}

if (n <= 1) {
  System.print(1)
  Fiber.suspend()
}

var res = 1
for (i in 1..n) {
  res = res * i
}

System.print(res)
