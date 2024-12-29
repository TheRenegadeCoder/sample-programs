import StringTools;

class Baklava {
    static private function repeatString(s:String, n:Int): String {
        return StringTools.rpad("", s, n);
    }

    static public function main() {
        for (n in -10...11) {
            var numSpaces = Std.int(Math.abs(n));
            var numStars = 21 - 2 * numSpaces;
            trace(repeatString(" ", numSpaces) + repeatString("*", numStars));
        }
    }
}
