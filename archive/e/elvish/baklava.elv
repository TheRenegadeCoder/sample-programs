# By github.com/Kaamkiya

for i [(range 11)] {
  var line = ''
  for j [(range (- 10 $i))] {
    set line = $line' '
  }
  for j [(range (+ 1 (* 2 $i)))] {
    set line = $line'*'
  }
  echo $line
}

for i [(range 9 -1)] {
  var line = ''
  for j [(range (- 10 $i))] {
    set line = $line' '
  }
  for j [(range (+ 1 (* 2 $i)))] {
    set line = $line'*'
  }
  echo $line
}
