import Foundation

if CommandLine.arguments.count > 1 && !CommandLine.arguments[1].isEmpty {

    let count = CommandLine.arguments.count - 1
    
    let range = 1...count
    
    var myString = ""
    
    print(range)
    
    for num in range
    {
        myString += CommandLine.arguments[num]
        
        if num != count {
            myString += " "
        }
    }
    
    let firstLetterCapitalized = myString.prefix(1).uppercased() + myString.dropFirst()
    
    print(firstLetterCapitalized)
} else {
    print("Usage: please provide a string")
}
