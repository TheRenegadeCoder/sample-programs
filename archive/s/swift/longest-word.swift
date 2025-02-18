import Foundation

if (CommandLine.arguments.count < 2) {
    print("Usage: please provide a string")
}
else 
{
    var sentence = CommandLine.arguments[1]   
    sentence = sentence.replacingOccurrences(of: "\n", with: "")    //removing the break line if it contains any
    longestWord(input : sentence)
}

func longestWord(input : String) -> Void
{
    var longest = 0
    var testWord = ""

    if(input == "")
    {
         print("Usage: please provide a string")    //checking for empty string
    }

    else 
    {
        var substrings: [Substring] = []    //array to hold the array of the input strings
        substrings = input.split(separator: " ")        //splitting the array by spaces
        
        for word in substrings    //iterate through the array
        {
            testWord = word.trimmingCharacters(in: CharacterSet(charactersIn: " "))
            if(testWord.count > longest)    
            {
                longest = testWord.count    //obtaining the longest count of words
            }
        }
        print(longest)
    }
}
