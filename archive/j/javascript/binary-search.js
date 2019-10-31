let binarySearch = function (arr, x) { 
    let start=0, end=arr.length-1; 
           
    while (start<=end){ 
        let mid=Math.floor((start + end)/2); 
    
        if (arr[mid]===x) 
			return true;  
        else if (arr[mid] < x)  
             start = mid + 1; 
        else
             end = mid - 1; 
    } 
    return false; 
} 

let main = function (list,key) {
	let arr;
	arr = list.replace(/(\s|"|'|`)/g, '');
    arr = arr.split(',');
    arr = arr.map(function (n) {
        return parseInt(n, 10);
    });
	arr = arr.filter(n => n);
	key = parseInt(key, 10);
	
	let flag=1;
	for(var i=0;i<arr.length-1;i++)
		if(arr[i]>arr[i+1])
			flag=0;
	
	if(flag)
		console.log(binarySearch(arr,key));
	else
		console.log(`Usage: please provide a list of sorted integers ("1, 4, 5, 11, 12") and the integer to find ("11")`);
}

if(process.argv.length!=4)
	console.log(`Usage: please provide a list of sorted integers ("1, 4, 5, 11, 12") and the integer to find ("11")`);
else
	main(process.argv[2],process.argv[3]);
	
	