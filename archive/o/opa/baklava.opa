function page() {
    <pre>{baklava()}</pre>
}

function baklava() {
    recursive function baklava_rec(lines, n) {
        if (n > 0) lines + baklava_line(n) + baklava_rec(lines, n - 1) else lines + baklava_line(n)
    }

    baklava_rec("", 20)
}

function baklava_line(n) {
    num_spaces = Int.abs(n - 10)
    num_stars = 21 - 2 * num_spaces
    String.repeat(num_spaces, " ") + String.repeat(num_stars, "*") + "\n"
}

Server.start(
   Server.http,
   { title: "Baklava", page: page}
)
