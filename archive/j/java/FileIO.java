import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

public class FileIO {

	public static void main(String[] args) {

		// create a new file output.txt
		File file =new File("output.txt");

		//method to open a file and add contents
		writeToFile(file);
		//method to open the file and print its content line by line
		readFile(file);

	}

	public static void readFile(File file) {

		try {

			BufferedReader buffer=new BufferedReader(new FileReader(file));
			try {
				String nextLine=buffer.readLine();// read the file one line at a time
				while(nextLine!=null) {
					//display the line on the screen
					System.out.println(nextLine);
					nextLine=buffer.readLine(); // read the next line to print
				}
				buffer.close();
			} catch (IOException e) {

				System.out.println("Error occurred while reading the file");
			} 

		} catch (FileNotFoundException e) {

			System.out.println("Error occurred while opening the file!");
		}

	}

	public static void writeToFile(File file) {

		String content = "We wish you a Merry Christmas\n" + 
				"We wish you a Merry Christmas\n" + 
				"We wish you a Merry Christmas\n" + 
				"And a happy New Year.";
		try {
			FileWriter writer = new FileWriter(file);
			writer.write(content); 
			writer.close(); // closes the file
		} catch (IOException e) {

			System.out.println("Error occurred while writing contents to file!");
		}

	}

}

