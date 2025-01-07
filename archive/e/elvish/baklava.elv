# By github.com/Kaamkiya

for i [(range 11) (range 9 -1)] {
  var line = ''

  range (- 10 $i) | each { |_| set line = $line' '}
  range (+ 1 (* 2 $i)) | each { |_| set line = $line'*' }

  echo $line
}
