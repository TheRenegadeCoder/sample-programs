fun main(args: Array<String>) {

    fun longestWord(sentence: String): Any {
        if (sentence.length == 0){
            return "Usage: please provide a string"
        } else {
            var words = sentence.split(" ", "\t", "\n", "\r")
            var longest = 0
            for (word in words){
                when {
                    word.length > longest -> longest = word.length
                }
            }
            return longest
        }
    }    

    if (args.isNullOrEmpty()){
        println("Usage: please provide a string")
    } else {
        for (case in args){
                println(longestWord(case))
        }        
    }
    
}