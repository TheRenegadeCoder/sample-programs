using System;

namespace SamplePrograms
{
    public class FractionMath
    {
        private int numerator;
        private int denominator;

        public FractionMath(int numerator = 0, int denominator = 0)
        {
            if (denominator == 0)
            {
                throw new ArgumentException("Denominator cannot be zero.");
            }

            this.numerator = numerator;
            this.denominator = denominator;

            Simplify();
        }

        // public override bool Equals(object obj)
        // {
        //     if (obj is FractionMath other)
        //     {
        //         return this == other;  // Use the overloaded `==` operator
        //     }
        //     return false;
        // }

        // public override int GetHashCode()
        // {
        //     return (numerator, denominator).GetHashCode();
        // }


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

        public override string ToString() => $"{numerator}/{denominator}";  // Fixed semicolon here

        public static FractionMath Parse(string fractionString)  // Fixed Parse method
        {
            string[] numbers = fractionString.Split('/');
            if (numbers.Length != 2)
            {
                throw new FormatException("Invalid fraction. A format of 'numerator/denominator' is expected.");
            }

            int numerator = int.Parse(numbers[0]);
            int denominator = int.Parse(numbers[1]);

            return new FractionMath(numerator, denominator);
        }

        public static FractionMath operator +(FractionMath f1, FractionMath f2)
        {
            int newNumerator = f1.numerator * f2.denominator + f2.numerator * f1.denominator;
            int newDenominator = f1.denominator * f2.denominator;
            FractionMath result = new FractionMath(newNumerator, newDenominator);
            result.Simplify();  // Only simplify after the operation
            return result;
        }

        public static FractionMath operator -(FractionMath f1, FractionMath f2)
        {
            int newNumerator = f1.numerator * f2.denominator - f2.numerator * f1.denominator;
            int newDenominator = f1.denominator * f2.denominator;
            return new FractionMath(newNumerator, newDenominator);  // Fixed return
        }

        public static FractionMath operator *(FractionMath f1, FractionMath f2)
        {
            int newNumerator = f1.numerator * f2.numerator;
            int newDenominator = f1.denominator * f2.denominator;
            FractionMath result = new FractionMath(newNumerator, newDenominator);
            result.Simplify();  // Only simplify after the operation
            return result;
        }

        public static FractionMath operator /(FractionMath f1, FractionMath f2)
        {
            int newNumerator = f1.numerator * f2.denominator;
            int newDenominator = f1.denominator * f2.numerator;
            return new FractionMath(newNumerator, newDenominator);  // Fixed return
        }

        public static bool operator ==(FractionMath f1, FractionMath f2)
        {
            return f1.numerator * f2.denominator == f1.denominator * f2.numerator;
        }

        public static bool operator !=(FractionMath f1, FractionMath f2)
        {
            return !(f1 == f2);
        }

        public static bool operator >(FractionMath f1, FractionMath f2)
        {
            return f1.numerator * f2.denominator > f1.denominator * f2.numerator;
        }

        public static bool operator <(FractionMath f1, FractionMath f2)
        {
            return f1.numerator * f2.denominator < f1.denominator * f2.numerator;
        }

        public static bool operator >=(FractionMath f1, FractionMath f2)
        {
            return f1 > f2 || f1 == f2;
        }

        public static bool operator <=(FractionMath f1, FractionMath f2)
        {
            return f1 < f2 || f1 == f2;
        }

        public static void Main(string[] args)
        {
            if (args.Length != 3)
            {
                Console.WriteLine("Usage: ./fraction-math operand1 operator operand2");
                return;
            }

            try
            {
                FractionMath operand1 = Parse(args[0]);
                string operation = args[1];
                FractionMath operand2 = Parse(args[2]);

                FractionMath result;
                bool comparisonResult;

                switch (operation)
                {
                    case "+":
                        result = operand1 + operand2;
                        Console.WriteLine(result);
                        break;
                    case "-":
                        result = operand1 - operand2;
                        Console.WriteLine(result);
                        break;
                    case "*":
                        result = operand1 * operand2;
                        Console.WriteLine(result);
                        break;
                    case "/":
                        result = operand1 / operand2;
                        Console.WriteLine(result);
                        break;
                    case "==":
                        comparisonResult = operand1 == operand2;
                        Console.WriteLine(comparisonResult ? "1" : "0");
                        break;
                    case "!=":
                        comparisonResult = operand1 != operand2;
                        Console.WriteLine(comparisonResult ? "1" : "0");
                        break;
                    case ">":
                        comparisonResult = operand1 > operand2;
                        Console.WriteLine(comparisonResult ? "1" : "0");
                        break;
                    case "<":
                        comparisonResult = operand1 < operand2;
                        Console.WriteLine(comparisonResult ? "1" : "0");
                        break;
                    case ">=":
                        comparisonResult = operand1 >= operand2;
                        Console.WriteLine(comparisonResult ? "1" : "0");
                        break;
                    case "<=":
                        comparisonResult = operand1 <= operand2;
                        Console.WriteLine(comparisonResult ? "1" : "0");
                        break;
                    default:
                        Console.WriteLine($"Error: Invalid operator '{operation}'");
                        break;
                }
            }
            catch (Exception e)
            {
                Console.WriteLine($"Error: {e.Message}");
            }
        }
    }
}
