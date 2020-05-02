---
title: Import/Export in JavaScript  
layout: default  
last-modified: 2020-05-02
featured-image:  
tags: [javascript, import, export]  
authors:  
  - ray6464
---

In this article, we will look at how to export and import variables in JavaScript.

## How to Implement the Solution
___
Requirements to go through this example:  
1. NodeJS and must be installed globally.  
To check installation use the command "node -v", if everything goes right you should see a version number. That means that NodeJS is installed properly.  
___
Follow the subsequent steps to go through this example:-  
1. Create a new directory.  
2. In this directory create 2 new files named "export.js" and "import.js".  
3. Add the code provided below to their corresponding file.  
4. From the terminal/cmd move to this directory and execute the command "node import.js". This will the desired output in your terminal/cmd.  

Let's look at the code in detail:  

code for export.js:-  

```javascript
exports.myGreeting = "Hello World";

```

code for import.js:-  

```javascript
var myImport = require("./export");

console.log(myImport.myGreeting);

```

In the "export.js" file we have the "exports" object built into JavaScript (like document, or console). We have give the "exports" object a property named "myGreeting" with the value "Hello World".

What this does is that when another file wants to import a value/variable then it can extract that variable from the properties of the "exports" object of this file.

In the "imports.js" file we have a variable named "myImport" which uses the "require" keyword to extract the exports object from another file (in this case the "export.js" file) and assign it to the variable "myImport". Then we simply log the value of "myImport.myGreeting" which will be the same as the value of "exports.myGreeting" since "myImport" and "exports" is the same object now.

JavaScript Keywords used in this code:  
1. exports  
2. var  
3. require()  
4. console  

## How to Run Solution

To run this code you need to run this file in NodeJS. To do that you need to install NodeJS and then use a terminal/cmd to move to the directory where you are keeping the "export.js" and "import.js" files, and execute the command "node import.js".

## Further Reading

- Fill out as needed
