use str

fn die {
  echo 'Usage: please provide a list of integers ("1, 4, 5, 11, 12") and the integer to find ("11")'
  exit 1
}

fn validate-num {|n|
  try {
    var _ = (+ 4 $n)
  } catch _ {
    die
  }
}

if (> 2 (count $args)) {
  die
}

var list = [(str:split ', ' $args[0])]
for i $list {
  validate-num $i
}

var key = $args[1]
validate-num $key

for i $list {
  if (== $i $key) {
    echo true
    exit
  }
}

echo false
