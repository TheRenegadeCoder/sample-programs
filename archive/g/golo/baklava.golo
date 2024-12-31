module baklava

function main = |args| {
    for (var n = -10, n <= 10, n = n + 1) {
        let numSpaces = Math.abs(n)
        let numStars = 21 - 2 * numSpaces
        println(" " * numSpaces + "*" * numStars)
    }
}
