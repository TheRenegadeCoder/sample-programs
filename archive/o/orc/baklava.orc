def Baklava(start, end) =
    Ift(start <= end) >>
        Println(BaklavaLine(start)) >>
        Baklava(start + 1, end)

def BaklavaLine(n) = 
    val num_spaces = abs(n)
    val num_stars = 21 - 2 * num_spaces
    RepeatString(" ", num_spaces) + RepeatString("*", num_stars)

def RepeatString(s, n) = if n <: 1 then "" else s + RepeatString(s, n - 1)

Baklava(-10, 10) >>
stop
