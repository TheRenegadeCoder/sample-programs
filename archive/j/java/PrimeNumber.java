public class PrimeNumber {

	public static void main(String[] args) throws Exception {
		try {
			int n = Integer.parseInt(args[0]);
			
			if (n < 0)
				throw new Exception();
			
			else if (n % 2 == 0 && n != 2 || n == 0 || n == 1) {
				System.out.println("Composite");
				System.exit(0);
			}
				
			for (int i = 3; i <= Math.ceil(Math.sqrt(n)) + 1; i++)
				if ( n % i == 0 && n != i) {
					System.out.println("Composite");
					System.exit(0);
				}
			
				else if (i == Math.ceil(Math.sqrt(n)) + 1)
					System.out.println("Prime");
		}
		
		catch(Exception e) {
	            System.out.println("Usage: please input a non-negative integer");
        	    System.exit(1);
        	}
	}
	
}
