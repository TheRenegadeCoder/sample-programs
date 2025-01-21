import "os" for Process

var args = Process.arguments
if (args.count < 1 || args[0].count < 1) {
  System.print("Usage: please provide a string")
  Fiber.suspend()
}

var charCounts = {}
var dupes = false

for (c in args[0]) {
  if (charCounts[c] == null) {
    charCounts[c] = 0
  }
  charCounts[c] = charCounts[c] + 1
  if (charCounts[c] > 1) {
    dupes = true
  }
}

if (dupes) {
  for (entry in charCounts) {
    if (entry.value > 1) {
      System.print(entry.key + ": " + entry.value.toString)
    }
  }
} else {
  System.print("No duplicate characters")
}
