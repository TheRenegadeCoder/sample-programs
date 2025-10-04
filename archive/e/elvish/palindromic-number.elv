use str

fn die {
  echo 'Usage: please input a non-negative integer'
  exit 1
}

if (> 1 (count $args)) {
  die
}

var n = $args[0]

# Check if the number contains a decimal point
if (str:contains $n .) {
  die
}

try {
  var q = (+ $n 1)
} catch _ {
  die
}

if (> 0 $n) {
  die
}

if (eq $n (echo $n|rev)) {
  echo true
} else {
  echo false
}
