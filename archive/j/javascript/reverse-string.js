const reverse = s => s.split('').reverse().join('');

if (process.argv.length > 2) {
    console.log(reverse(process.argv[2]));
}
