const die = () => {
  console.log("Usage: please provide a string");
  process.exit(1);
}

if (process.argv.length != 3) {
  die();
}

if (process.argv[2].length > 0) console.log(process.argv[2].replaceAll(/\s/g, ''));
else die();
