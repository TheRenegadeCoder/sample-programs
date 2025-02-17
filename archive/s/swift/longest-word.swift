import Foundation

var sentence = CommandLine.arguments.joined(separator: " ")    //changing the array of string into a single string

sentence = sentence.replacingOccurrences(of: "\n", with: "")    //removing the break line if it contains any

longestWord(input : sentence)

func longestWord(input : String) -> Void
{
    var longest = 0
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
            if(word.count > longest)    
            {
                longest = word.count    //obtaining the longest count of words
            }
        }
        print(longest)
    }
}
