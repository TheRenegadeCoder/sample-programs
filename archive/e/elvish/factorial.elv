if (> 1 (count $args)) {
  echo "Usage: please input a non-negative integer"
  exit 1
}

try {
  var r = (+ $args[0] 1) # Hacky, but it tries to add the argument with one.
} catch { # If it fails, the value is not a number.
  echo "Usage: please input a non-negative integer"
  exit 1
}

if (> 0 $args[0]) {
  echo "Usage: please input a non-negative integer"
  exit 1
}

var f = 1

for i [(range 1 (+ 1 $args[0]))] {
  set f = (* $f $i)
}

echo $f
