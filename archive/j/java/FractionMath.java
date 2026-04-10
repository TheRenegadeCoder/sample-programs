public class FractionMath {
    private static void usage() {
        System.out.println("Usage: ./fraction-math operand1 operator operand2");
        System.exit(1);
    }

    private record Fraction(int n, int d) implements Comparable<Fraction> {
        private Fraction {
            if (d == 0) throw new IllegalArgumentException();

            int gcd = gcd(Math.abs(n), Math.abs(d));
            n /= gcd;
            d /= gcd;

            if (d < 0) {
                n = -n;
                d = -d;
            }
        }

        static Fraction parse(String s) {
            String[] p = s.trim().split("/");

            if (p.length != 2) {
                throw new IllegalArgumentException("Invalid fraction: " + s);
            }

            return new Fraction(Integer.parseInt(p[0].trim()), Integer.parseInt(p[1].trim()));
        }

        Fraction add(Fraction o) {
            return new Fraction(n * o.d + o.n * d, d * o.d);
        }

        Fraction sub(Fraction o) {
            return new Fraction(n * o.d - o.n * d, d * o.d);
        }

        Fraction mul(Fraction o) {
            return new Fraction(n * o.n, d * o.d);
        }

        Fraction div(Fraction o) {
            if (o.n == 0) throw new ArithmeticException("Division by zero");
            return new Fraction(n * o.d, d * o.n);
        }

        private static int gcd(int a, int b) {
            return b == 0 ? Math.abs(a) : gcd(b, a % b);
        }

        @Override
        public String toString() {
            return n + "/" + d;
        }

        @Override
        public boolean equals(Object obj) {
            if (this == obj) return true;
            if (!(obj instanceof Fraction f)) return false;
            return n == f.n && d == f.d;
        }

        @Override
        public int hashCode() {
            return 31 * n + d;
        }

        @Override
        public int compareTo(Fraction o) {
            return Long.compare((long) n * o.d, (long) d * o.n);
        }
    }

    public static void main(String[] args) {
        if (args.length != 3) {
            usage();
        }

        try {
            Fraction a = Fraction.parse(args[0]);
            String op = args[1];
            Fraction b = Fraction.parse(args[2]);

            switch (op) {
                case "+" -> System.out.println(a.add(b));
                case "-" -> System.out.println(a.sub(b));
                case "*" -> System.out.println(a.mul(b));
                case "/" -> System.out.println(a.div(b));

                case "==" -> System.out.println(a.equals(b) ? "1" : "0");
                case "!=" -> System.out.println(!a.equals(b) ? "1" : "0");
                case ">" -> System.out.println(a.compareTo(b) > 0 ? "1" : "0");
                case "<" -> System.out.println(a.compareTo(b) < 0 ? "1" : "0");
                case ">=" -> System.out.println(a.compareTo(b) >= 0 ? "1" : "0");
                case "<=" -> System.out.println(a.compareTo(b) <= 0 ? "1" : "0");

                default -> usage();
            }

        } catch (Exception e) {
            usage();
        }
    }
}
