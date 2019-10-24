import Prog1Tools.IOTools;

public class CesarCipher {

	public static void main(String[] args) {
		int count;
		count = IOTools.readInt("Enter the number of characters which shall be read: ");
		char[] word = readChars(count);
		System.out.println(word);

		int step = 0;

		while (step == 0) {
			System.out.println("Enter command (shift or exit): ");

			step = getCommand();

			if (step == 0) {

				int displacement = IOTools.readInt("Enter the shift offset: ");
				System.out.println("Message before shifting: ");
				printArray(word);
				shift(word, displacement);
				System.out.println("Message after shifting: ");
				printArray(word);

			} else if (step == 1) {
				System.out.println("Bye bye.");
			}

		}

	}

	public static void printArray(char[] args) {

		for (int i = 0; i < args.length; i++) {

			System.out.print(args[i]);
		}
		System.out.println(" ");

	}

	public static char[] readChars(int number) {

		char[] word = new char[number];

		for (int i = 0; i < word.length; i++) {
			word[i] = IOTools.readChar("Please insert Char number " + (i + 1) );
		}
		return word;
	}

	public static void shift(char[] word, int shift) {
		int wordInt;
		for (int i = 0; i < word.length; i++) {
			wordInt = (int) word[i];
			wordInt = wordInt + shift;
			word[i] = (char) wordInt;
		}
	}

	public static int getCommand() {
		int answer = 2;
		boolean end = false;

		while (!end) {

			String words = IOTools.readString();

			if (words.equals("shift")) {
				end = true;
				answer = 0;

			}
			if (words.equals("exit")) {
				end = true;
				answer = 1;

			}
		}
		return answer;

	}

}