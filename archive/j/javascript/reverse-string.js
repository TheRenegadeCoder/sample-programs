function reverse(s) {
  return s.split('').reverse().join('');
}

function main() {
  var toReverse = prompt("Enter a String", "Hello, World!");
  if (toReverse != null) {
      console.log(reverse(toReverse))
  }
}

main()
