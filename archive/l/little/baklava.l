string repeat_string(string s, int n) {
    int i;
    string result = "";
    for (i = 0; i < n; i++) {
        result[END + 1] = s;
    }

    return result;
}

int n, numSpaces, numStars;
for (n = -10; n <= 10; n++) {
    numSpaces = abs(n);
    numStars = 21 - 2 * numSpaces;
    printf("%s%s\n", repeat_string(" ", numSpaces), repeat_string("*", numStars));
}
