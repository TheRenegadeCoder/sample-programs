import extensions;
import extensions'text;
import extensions'math;

public program()
{
    int space := " ".toChar();
    int star := "*".toChar();
    for (int n := -10; n <= 10; n++) {
        int num_spaces := abs(n);
        int num_stars := 21 - 2 * num_spaces;
        console.writeLine(String.fill(num_spaces, space) + String.fill(num_stars, star));
    }
}
