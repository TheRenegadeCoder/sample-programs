fun String.reverseCaseOfString(): String {
    val inputCharArr = toCharArray() // Converting the input to char array
    var output = ""
    for (i in 0 until inputCharArr.size) {
        output += if (inputCharArr[i].isUpperCase()) { // Checking the character is in uppercase or not
            inputCharArr[i].toLowerCase() // Converting the char to lower case
        } else {
            inputCharArr[i].toUpperCase() // Converting the char to upper case
        }
    }
    return output
}
