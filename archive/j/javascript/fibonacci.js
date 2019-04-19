function fibonacci(num) {
    let n = Number(num);
    let first = 0;
    let second = 1;
    let result = 0;
    for (let i = 1; i <= n; i++) {
    	result = first + second;
    	first = second;
    	second = result;
        console.log(i + ": " + first);
    }
}

num = process.argv[2];

if (num && !isNaN(num)) {
    fibonacci(num);
} else {
    console.log("Usage: please input the count of fibonacci numbers to output")
}
