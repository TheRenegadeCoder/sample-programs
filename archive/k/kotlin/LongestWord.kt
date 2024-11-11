fun main(args: Array<String>) {

    fun longestWord(sentence: String): Any {
        // if sentence is empty, ask for a String
        if (sentence.length == 0){
            return "Usage: please provide a string"
        } else {
            // split sentence from these delimeters and put resulting strings into words list
            var words = sentence.split(" ", "\t", "\n", "\r")
            var longest = 0
            // iterate through words list and compare each word length to longest var
            // if word length is larger, then the var longest will be assigned the word length
            for (word in words){
                when {
                    word.length > longest -> longest = word.length
                }
            }
            // return var longest which holds the largest string length in the sentence parameter
            return longest
        }
    }    

    // if console input is null, ask for String
    if (args.isNullOrEmpty()){
        println("Usage: please provide a string")
    } else {
        // if console input is not null, then find longestWord of input String
        println(longestWord(args[0]))    
    }
    
}