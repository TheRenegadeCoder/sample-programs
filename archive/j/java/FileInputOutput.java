import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

public class FileInputOutput {

    public static void main(String[] args) {
        File file = new File("output.txt");
        writeToFile(file);
        readFile(file);
    }

    public static void readFile(File file) {

        try {

            BufferedReader buffer = new BufferedReader(new FileReader(file));
            try {
                String nextLine = buffer.readLine();
                while (nextLine != null) {
                    System.out.println(nextLine);
                    nextLine = buffer.readLine();
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
            writer.close();
        } catch (IOException e) {

            System.out.println("Error occurred while writing contents to file!");
        }

    }

}
