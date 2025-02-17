import "os" for Process

var args = Process.arguments

if (args.count != 1 || args[0] == "") {
  System.print("Usage: please provide a string")
  Fiber.suspend()
}

var chars = {}
var order = []
var dupes = false

for (c in args[0]) {
  if (chars[c] == null) {
    chars[c] = 0
  } else {
    dupes = true
  }

  chars[c] = chars[c] + 1

  var contains = false
  for (a in order) {
    if (c == a) {
      contains = true
      break
    }
  }

  if (!contains) {
    order.add(c)
  }
}

if (dupes) {
  for (c in order) {
    if (chars[c] > 1) {
      System.print(c + ": " + chars[c].toString)
    }
  }
} else {
  System.print("No duplicate characters")
}
