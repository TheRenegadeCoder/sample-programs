import "os" for Process

var args = Process.arguments // Process.args is a bit long and annoying to type.

if (args.count < 1 || args[0].count < 1) {
  System.print("Usage: please input a number")
  Fiber.suspend()
}

var n = Num.fromString(args[0])

if (n == null) {
  System.print("Usage: please input a number")
  Fiber.suspend()
}

if (n % 2 == 0) {
  System.print("Even")
} else {
  System.print("Odd")
}
