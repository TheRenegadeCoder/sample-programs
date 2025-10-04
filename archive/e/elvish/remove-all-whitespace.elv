use re

if (> 1 (count $args)) {
  echo "Usage: please provide a string"
  exit 1
}

if (> 1 (count $args[0])) {
  echo "Usage: please provide a string"
  exit 1
}

echo (re:replace '\s' '' $args[0])
