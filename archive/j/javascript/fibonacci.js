function fibonacci(num) {
    var n = Number(num);
    var first = 0;
    var second = 1;
    var result = 0;
    for (var i = 1; i <= n; i++) {
    	result = first + second;
    	first = second;
    	second = result;
        console.log(i + ": " + first + "\n");
    }
}

fibonacci(process.argv[0])
