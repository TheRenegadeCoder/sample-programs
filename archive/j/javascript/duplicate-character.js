const error = () => {
  console.log("Usage: please provide a string");
};

const args = process.argv;

try {
  let flag = false;
  const map = new Map();
  const inputStr = args[2];
  if (inputStr !== undefined) {
    for (const char of inputStr) {
      const value = map.has(char) === true ? map.get(char) : 0;
      map.set(char, value + 1);
    }
    for (const m of map) {
      if (m[1] > 1) {
        flag = true;
        console.log(`${m[0]}: ${m[1]}`);
      }
    }
  }
  if (flag === false) {
    console.log("No duplicate characters");
  }
} catch (_error) {
    console.log(_error);
  error();
}
