---
title: Import/Export in TypeScript  
layout: default  
last-modified: 2019-10-06  
featured-image:  
tags: [typescript, import, export]  
authors:  
  - ray6464
---

In this article, we will look at how to export and import variables in TypeScript.

## How to Implement the Solution
___
Requirements to go through this example:  
1. NodeJS and must be installed globally.  
2. You must have TypeScript Installed globally.  
To check installation use the command "node -v && tsc -v", if everything goes right you should see two version numbers. That means both these things are installed properly.  
___

Follow the subsequent steps to go through this example:-
1. Create a new directory.  
2. In this directory create 2 new files named "export.ts" and "import.ts".  
3. Add the code provided below to their corresponding file.  
4. From the terminal/cmd move to this directory and execute the command "tsc export.ts import.ts".  
5. From the terminal/cmd while in this directory execute the command "node import.js" (yes ".js"!). This will the desired output in your terminal/cmd.  

Let's look at the code in detail:  

code for export.ts:-  

```javascript
export const myGreeting = "Hello World";

```

code for import.ts:-  

```javascript
import { myGreeting } from "./export";

console.log(myGreeting);

```

In the "export.ts" file we have use the "export" keyword to export the constant "myGreeting" to other importing files.

In the "imports.ts" file we have used the "import" keyword to import the "myGreeting" value from the file "export.js".

Notice here that we need to know the name of the exported variable to import it, and we need to add the "./" prefix for exporting files placed in the same directory as the importing file.

Then we simply logged "myGreeting" to the console.


JavaScript Keywords used in this code:  
1. export  
2. const  
3. import  
4. from  
5. console    

## How to Run Solution

First you need to install TypeScript then verify installation with "tsc -v". Then use the command "tsc export.ts import.ts" to compile TypeScript code to JavaScript. After compiling you will have two more files in this directory named "export.js" and "import.js".

Then To run this code you need to run this file in NodeJS. To do that you need to install NodeJS and then use a terminal/cmd to move to the directory where you are keeping the "export.js" and "import.js" files, and execute the command "node import.js".
