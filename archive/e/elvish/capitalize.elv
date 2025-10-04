use str

fn die {
  echo 'Usage: please provide a string'
  exit 1
}

if (> 1 (count $args)) {
  die
}

var s = $args[0]

if (> 1 (count $s)) {
  die
}

echo (str:join '' [(str:to-upper $s[0]) $s[1..]])
