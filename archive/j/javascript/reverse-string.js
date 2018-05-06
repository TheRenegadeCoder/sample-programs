const readline = require('readline');

const reverse = s => s.split('').reverse().join('');

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

const question = 'Enter a String: ';

rl.question(question, (answer) => {
  console.log(reverse(answer));
  rl.close();
});
