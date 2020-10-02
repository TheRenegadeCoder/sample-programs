/*
Author : Nameer Waqas
Date: 02/10/2020
Title: Implementation of Palindrome algorithm in JS
Test case: "civic"
*/

function checkPalindrome(param=""){
    let check = true;
    if(param=="") return check;
    param = param.toString()
    let charArr = param.split('')
    for(var i =0,j=charArr.length-1;i<=parseInt(charArr.length/2)-1;i++,j--){
        if(charArr[i]!=charArr[j]){
            check = false;
            break;
        }
    }
    return check;
}

checkPalindrome('civic')
// true