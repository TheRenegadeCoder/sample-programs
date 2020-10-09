data class EncodingBounds(val lowerBound: Int, val upperBound: Int)

fun encodingBoundsForCharValue(c: Char): EncodingBounds? {
    val lowerCaseBounds = EncodingBounds('a'.toInt(), 'z'.toInt())
    val upperCaseBounds = EncodingBounds('A'.toInt(), 'Z'.toInt())
    return when (c) {
        in 'a'..'z' -> lowerCaseBounds
        in 'A'..'Z' -> upperCaseBounds
        else -> null
    }
}

fun calculateRotatedChar(char: Char, rotation: Int, bounds: EncodingBounds): Char {
    val rotatedCharVal = char.toInt() + rotation
    val remainder = rotatedCharVal - (bounds.upperBound + 1)
    return (if (rotatedCharVal > bounds.upperBound) bounds.lowerBound + remainder else rotatedCharVal).toChar()
}

fun parseInput(args: Array<String>): String? {
    if (args.isEmpty()) {
        return null
    }
    val text = args[0]
    if (text.isEmpty()) {
        return null
    }
    return text
}

fun rot13Encode(text: String): String {
    val rotation = 13

    return text.map { c ->
        val bounds = encodingBoundsForCharValue(c)
        if (bounds == null) {
            c.toString()
        } else {
            calculateRotatedChar(c, rotation, bounds).toString()
        }
    }.reduce { encodedText, encodedChar ->
        encodedText + encodedChar
    }

}

fun main(args: Array<String>) {
    val strToEncode = parseInput(args)
    if (strToEncode == null) {
        println("Usage: please provide a string to encrypt")
    } else {
        println(rot13Encode(strToEncode))
    }
}
