function rot13(input: string): string {
  if (!input) {
      return "Usage: please provide a string to encrypt";
  }

  return input.split('').map(char => {
      const code = char.charCodeAt(0);
      // Check if the character is an uppercase letter
      if (code >= 65 && code <= 90) {
          return String.fromCharCode((code - 65 + 13) % 26 + 65);
      }
      // Check if the character is a lowercase letter
      else if (code >= 97 && code <= 122) {
          return String.fromCharCode((code - 97 + 13) % 26 + 97);
      }
      // If it's not a letter, return the character unchanged
      return char;
  }).join('');
}

const args = process.argv.slice(2);

if (args.length !== 1) {
  console.log("Usage: please provide a string to encrypt");
  process.exit(1);
} else {
  const input = args[0];
  const result = rot13(input);
  console.log(result);
}
