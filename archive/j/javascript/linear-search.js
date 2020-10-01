/*
Author : Nameer Waqas
Date: 01/10/2020
Title: Implementation of Linear search algorithm in JS
Algorithm Big-O = O(n)
*/

function LinSearch(arr = [], valToSearch) {
    let check = false;
    if (arr.length == 0) return check
    if(valToSearch==='') return check
    else {
        for (i = 0; i < arr.length; i++) {
            if (arr[i] == valToSearch){
                check = true
                return check
            }
        }
        return check
    }
}