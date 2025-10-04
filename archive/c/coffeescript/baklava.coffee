for i in [0...10]
  pattern = " ".repeat (10 - i)
  pattern += "*".repeat (i * 2 + 1)
  console.log pattern

for i in [10..0]
  pattern = " ".repeat (10 - i)
  pattern += "*".repeat (i * 2 + 1)
  console.log pattern