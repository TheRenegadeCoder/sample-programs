import java.util.Scanner;

public class CheckPrime {

    public static void main(String[] args) {

        int num, i, flag = 0;

        //Input from the user
        System.out.println("Enter a number to check if it is prime or not :");
        Scanner scan = new Scanner(System.in);
        num = scan.nextInt();

        //Code to check if the input number is a prime number or not
        for (i = 1; i < num / 2; i++) {
            if (num % i == 0) {
                flag++;
                break;
            }
        }
        if (num == 1 || num == 0 || num < 0) {
            System.out.println("The number " + num + " is neither a prime nor a composite number.");
        } else if (flag == 0) {
            System.out.println("The number " + num + " is a prime number.");
        } else {
            System.out.println("The number " + num + " is not a prime number.");
        }


    }
}

