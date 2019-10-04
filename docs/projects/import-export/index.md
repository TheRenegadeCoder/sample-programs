---
title: Exporting & Importing variables in Every Language
layout: default
date: 2019-10-04
last-modified: 2019-10-04
featured-image:
tags: [Export, Import]
authors:
---
   --Ray6464 

Exporting and Importing data is required to create modules. What we basically do is create variables in one file (say this file's name is "export"), export them from the "export" file; then import them from another file (say the file's name is "import"), then use them in the "import" file.

## Requirements

In this example the goal is to write a variable in one file, and log it's value in another file. Preferably using keywords like import, export, require, etc.

## Testing

Supposing that you have 2 files in the same directory, named "import" and "export" with your code in them. If "export" has a variable, then you should be able to log/print it from "import". Follow is some mock-code as an example:-  

export file:-  
```
int x = 123;  
```  
```
let y = "Hello";  
```  

import file:-  
```
printf(x);       //prints: 123
```  
```
console.log(y);  //logs: "Hello"  
```
## Articles

{% include article_list.md collection=site.categories.reverse-a-string %}

## Further Reading

// needs improvement