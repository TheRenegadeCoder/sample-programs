use str
use math

fn die {
  echo 'Usage: please input a non-negative integer'
  exit 1
}

if (> 1 (count $args)) {
  die
}

var n = 0
try {
  set n = (num $args[0])
} catch _ {
  die
}

if (or (> 0 $n) (str:contains (to-string $n) .)) {
  die
}

if (> 2 $n) {
  echo 'composite'
  exit 0
}

if (== $n 2) {
  echo 'prime'
  exit 0
}

for i [(range 2 (+ 1 (exact-num (math:ceil (math:sqrt $n)))))] {
  if (== 0 (% $n $i)) {
    echo 'composite'
    exit 0
  }
}

echo 'prime'
