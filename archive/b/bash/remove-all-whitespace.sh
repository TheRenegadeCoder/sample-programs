#~/usr/bin/bash
if [ -z "$1" ]; then
  echo "Usage: please provide a string"
fi
echo "$1" | tr -d ' ' | sed -E  's,\\[trn],,g'
