import foundation

let input = CommandLine.arguments

func longestWord(input) -> any
{
    if(input == "")
    {
        return "Usage: please provide a string"
    }

    else 
    {
        var substrings: [Substring] = []    //array to hold the array of the input strings
        substrings = input.split(separator: " ")        //splitting the array by spaces
        
        for word in substrings    //iterate through the array
        {
            if(words.count > longest)    
            {
                longest = words.count
            }
        }
    }
}
