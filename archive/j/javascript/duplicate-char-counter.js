const string = process.argv[2];
if (!string) return console.log("Please provide a string.");

chars_counter = {};

for (const char of string) {
    if (!chars_counter[char]) chars_counter[char] = 0;
    chars_counter[char] += 1;
}

for (const char_count of Object.entries(chars_counter)) {
    if (char_count[1] >= 2) {
        console.log(
            `Character: ${char_count[0]}, Occurrences: ${char_count[1]}`
        );
    }
}
