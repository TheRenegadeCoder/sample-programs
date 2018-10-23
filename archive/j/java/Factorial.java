import java.util.Scanner;

public class Factorial {

	public static void main (String[] args) {
		

		Scanner sc = new Scanner(System.in);
		

		System.out.println("Type a number to factorise: ");
		int num = sc.nextInt();
		
		int resAcum = 1 ;
		for (int cont = num; cont >= 1 ; cont --) 
		{
			
			resAcum = resAcum * cont;
			
		} 
		System.out.println("The factorial of " + num + " is " + resAcum + ".");
		
		
	}

}
