import Foundation

var sentence = CommandLine.arguments

sentence = sentence.replacingOccurrences(of: "\n", with: "")    //removing the break line if it contains any

longestWord(input : sentence)

func longestWord(input : String) -> any
{
    if(input == "")
    {
        return "Usage: please provide a string"    //checking for empty string
    }

    else 
    {
        var substrings: [Substring] = []    //array to hold the array of the input strings
        substrings = input.split(separator: " ")        //splitting the array by spaces
        
        for word in substrings    //iterate through the array
        {
            if(words.count > longest)    
            {
                longest = words.count    //obtaining the longest count of words
            }
        }
    }
}
