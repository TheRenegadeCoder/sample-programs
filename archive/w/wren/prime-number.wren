import "os" for Process

var args = Process.arguments

if (args.count < 1 || args[0].count < 1) {
  System.print("Usage: please input a non-negative integer")
  Fiber.suspend()
}

var n = Num.fromString(args[0])

if (n == null || n < 0 || n.floor != n) {
  System.print("Usage: please input a non-negative integer")
  Fiber.suspend()
}

if (n < 2) {
  System.print("composite")
  Fiber.suspend()
}

if (n == 2) {
  System.print("prime")
  Fiber.suspend()
}

for (i in 2..(n.sqrt.floor)) {
  if (n % i == 0) {
    System.print("composite")
    Fiber.suspend()
  }
}
System.print("prime")
