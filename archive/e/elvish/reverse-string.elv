if (> 1 (count $args)) {
  echo ''
  exit
}

echo $args[0] | rev
