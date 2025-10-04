def baklavaLine(n: Int32): String =
    let numSpaces = Int32.abs(n);
    let numStars = 21 - 2 * numSpaces;
    String.repeat(numSpaces, " ") + String.repeat(numStars, "*")

def main(): Unit \ IO =
    List.range(-10, 11) |>
    List.map(baklavaLine) |>
    List.forEach(println)
