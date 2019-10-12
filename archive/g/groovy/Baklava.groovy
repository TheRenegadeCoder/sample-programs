(0..9).each{ index ->
    println "${' ' * (10 - index)}${'*' * (index * 2 + 1)}"
}
(9..0).each{ index ->
    println "${' ' * (10 - index)}${'*' * (index * 2 + 1)}"
}