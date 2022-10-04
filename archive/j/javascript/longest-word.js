const error = () => {
  console.log("Usage: please provide a string");
};

const args = process.argv;

try {
  const inputStr = args[2];
  const words = inputStr.split(" ");
  let maxSize = -1;
  words.forEach(({ length }) => {
    maxSize = length > maxSize ? length : maxSize;
  });

  console.log(maxSize);
} catch (_error) {
  error();
}
