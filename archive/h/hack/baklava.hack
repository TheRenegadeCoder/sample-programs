use namespace HH\Lib\Str;

<<__EntryPoint>>
function main(): void {
    for ($n = -10; $n <= 10; $n++) {
        $numSpaces = abs($n);
        $numStars = 21 - 2 * $numSpaces;
        echo Str\repeat(" ", $numSpaces) . Str\repeat("*", $numStars) . "\n";
    }
}
