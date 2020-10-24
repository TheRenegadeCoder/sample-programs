import java.util.Scanner;

class Five{
    public static void main(String args[]){
        double pi = 3.14;
        int r;
        Scanner in = new Scanner(System.in);
        System.out.println("Enter radius of circle ");
        r = in.nextInt();
        System.out.println("Area of circle is " + (pi*r*r));
        System.out.println("Circumference of circle is " + (2*pi*r));
    }
}