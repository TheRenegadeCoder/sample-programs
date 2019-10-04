function insertionSort(numbers){
    for(let i = 0;i < numbers.length;i++) {
        let j = i-1;
        let tmp = numbers[i];
        while(j >= 0 && numbers[j] > tmp) {
            numbers[j+1] = numbers[j]
            j--;
        }
        numbers[j+1] = tmp;
    }
    return numbers;
}


nums = process.argv.slice(2,process.argv.length);
nums = nums.map(function(i) {
    return parseInt(i);
})

if(!nums || nums.length === 1) {
    console.log("Usage: please provide a list of at least two integers to sort in the format '1, 2, 3, 4, 5'");
} else {
    console.log(insertionSort(nums))
}
