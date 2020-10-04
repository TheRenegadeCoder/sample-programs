/** Prime number exception to handle errors. */
class PrimeNumberException extends Exception {}

/**
 * Prime number program.
 */
public class PrimeNumber {

    /**
     * Determine if an integer is a prime number.
     * @param number Non negative integer to check.
     * @return true if the number is prime, false otherwise.
     */
    public static boolean isPrime(int number) {
        if ((number % 2 == 0 && number != 2) || number == 1) {
            return false;
        }

        boolean foundFactor = false;
        for (int n = 3; n <= (int) Math.ceil(Math.sqrt(number)); ++n) {
            if ((number % n) == 0) {
                foundFactor = true;
                break;
            }
        }
        return !foundFactor;
    }

    /**
     * Main.
     * @param args command line arguments.
     */
    public static void main(String[] args) {
        try {

            // Check argument
            if (args.length < 1 || args[0].indexOf('-') != -1) {
                throw new PrimeNumberException();
            }

            // Convert to int and check
            if (isPrime(Integer.valueOf(args[0]))) {
                System.out.println("Prime");

            } else {
                System.out.println("Composite");
            }

        } catch (NumberFormatException | PrimeNumberException e) {
            System.err.println("Usage: please input a non-negative integer");
        }
    }
}
