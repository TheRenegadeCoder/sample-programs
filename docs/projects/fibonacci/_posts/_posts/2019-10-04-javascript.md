---
title: Fibonacci sequence in JavaScript  
layout: default  
last-modified: 2019-10-01 4
featured-image:  
tags: [javascript, fibonacci]  
authors:[ Alina1Black ]

---

In this article, we will write an algorithm of the Fibonacci sequence in JavaScript.

## How to Implement the Solution

Let's look at the code in detail:  

code for fibonacci.js:-  

```javascript
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

num = 10; //we want to print the first 10 Fibonacci numbers

if (num && !isNaN(num)) {
    fibonacci(num);
} else {
    console.log("Usage: please input the count of fibonacci numbers to output")
}

```

Here we have a function called "fibonacci" that takes in a numeric value as an argument that corresponds to the amount fibonacci numbers we want to print in succession.

What "fibonacci" does is that it starts printing from 1 then each time it just prints the accumulation of the last number it printed (stored in variable named "second") and the 2nd last number it printed (stored in variable named "first").

Then we have a variable named "num" which has a numeric value of "10" since we want to print the first 10 numbers in the Fibonacci sequence.

Then we have a function that verifies that "num" has a positive, numeric value so we can run the function named "fibonacci", else it just returns an instruction/warning.

## How to Run Solution

Copy/paste the code provided in a JavaScript file and link the script in a web page.

For example:-
If you copy/paste this code in a file named "fibonacci.js" then use copy/paste the following tag in your HTML file:
```html
<script src="fibonacci.js"></script>
```

Also make sure that "fibonacci.js" is in the same folder/directory as your HTML file.