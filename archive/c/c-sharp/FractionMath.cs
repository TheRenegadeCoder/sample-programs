namespace SamplePrograms
{
    public class FractionMath
    {
        private int numerator;
        private int denominator;
        
        public FractionMath(int numerator, int denominator) {
            if (denominator == 0) {
                System.Console.WriteLine("Denominator cannot be zero"); // Look into different types of exceptions
            }
            
            this.numerator = numerator;
            this.denominator = denominator;

            // Make sure to simplify the fraction using GCD
        }
        
        private int GCD(int x, int y) {
            // look into creating the GCD method
        }
        
    }
}