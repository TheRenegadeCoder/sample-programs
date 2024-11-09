fun main(args: Array<String>) {

    fun longestWord(sentence: String) {
        var words = sentence.split(" ")
        var longest = 0
        for (word in words){
            when {
                word.length > longest -> longest = word.length
            }
        }
        return longest
    }

}