use str

if (> 1 (count $args)) {
  echo "Usage: please provide a string to encrypt"
  exit 1
}
if (== 0 (str:compare $args[0] '')) {
  echo "Usage: please provide a string to encrypt"
  exit 1
}

echo $@args | tr 'A-Za-z' 'N-ZA-Mn-za-m'
