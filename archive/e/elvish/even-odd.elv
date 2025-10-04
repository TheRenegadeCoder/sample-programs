use re

if (> 1 (count $args)) {
  echo "Usage: please input a number"
  exit 1
}

if (not (re:match '^[+-]?[0-9]+(\.[0-9]+)?$' $args[0])) {
  echo "Usage: please input a number"
  exit 1
}

if (== 0 (% $args[0] 2)) {
  echo Even
} else {
  echo Odd
}
