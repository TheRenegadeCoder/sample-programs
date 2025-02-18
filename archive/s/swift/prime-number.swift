import Foundation

//Check if a number is prime
func isPrime(number: Int) -> Bool{

    //number less than two are not prime
    if number <= 1{
        return false
    }

    //check if number can be divided by any number from 2 to -1
    for i in 2..<number{
        if number % i == 0{
            return false
        }
    }

    return true 


}



