if (> 1 (count $args)) {
  echo "Usage: please input the count of fibonacci numbers to output"
  exit 1
}

try {
  var r = (+ $args[0] 1) # Hacky, but it tries to add the argument with one.
} catch { # If it fails, the value is not a number.
  echo "Usage: please input the count of fibonacci numbers to output"
  exit 1
}

var a = 0
var b = 1
var c = 0

for i [(range 1 (+ $args[0] 1))] {
  set c = (+ $a $b)
  set a = $b
  set b = $c
  echo $i': '$a
}
