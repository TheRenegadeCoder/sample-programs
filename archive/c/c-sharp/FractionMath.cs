namespace SamplePrograms
{
    public class FractionMath
    {
        private int numerator;
        private int denominator;

        public FractionMath(int numerator, int denominator)
        {
            if (denominator == 0)
            {
                throw new ArgumentException("Denominator cannot be zero.");
            }

            this.numerator = numerator;
            this.denominator = denominator;

            Simplify();
        }

        // GCD method using the Euclidean algorithm in an iterative approach
        // Orginal algorithm was found on GeeksforGeeks, modified for clarity:
        // https://www.geeksforgeeks.org/program-to-find-gcd-or-hcf-of-two-numbers/#
        private int GCD(int x, int y)
        {

            while (y != 0)
            {
                int z = x;
                x = y;
                y %= z;
            }

            return x;
        }

        private void Simplify()
        {
            int gcd = GCD(numerator, denominator);

            numerator /= gcd;
            denominator /= gcd;

            if (denominator < 0)
            {
                numerator = -numerator;
                denominator = -denominator;
            }
        }

        public FractionMath StringToFraction(string fractionString) {
            string[] numbers = fractionString.Split('/');

            if (numbers.Length != 2) {
                throw new FormatException("Invalid fraction. A format of 'numerator/denominator' is expected.");
            } 

            int numerator = int.Parse(numbers[0]);
            int denominator = int.Parse(numbers[1]);
            
            if (denominator == 0)
            {
                throw new ArgumentException("Denominator cannot be zero.");
            }

            return new FractionMath(numerator, denominator);
        }
    }