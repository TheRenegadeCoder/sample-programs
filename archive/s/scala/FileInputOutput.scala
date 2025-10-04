import scala.io.Source
import java.io.{FileNotFoundException, IOException, File, FileOutputStream, PrintWriter}

object FileInputOutput {
  // reading file then write to stdout
  // write exception when fail
  def readFromFile(filename: String) {
    try {
      val buffer = Source.fromFile(filename)
      val lines = buffer.getLines

      lines.foreach(println)
      buffer.close
    } catch {
      case e: FileNotFoundException => println(s"File ${filename} does not exist.")
      case e: IOException => println(s"I/O Exception when reading from ${filename}.")
      case e: Throwable => println(s"Error ${e.getMessage} when reading from ${filename}.")
    }
  }

  // write to file
  // stdout exception when fail
  def writeToFile(filename: String, contents: String) {
    try {
      val writer = new PrintWriter(new File(filename))
      writer.write(contents)
      writer.close
    } catch {
      case e: FileNotFoundException => println(s"Cannot write into file ${filename}.")
      case e: Throwable => println(s"Error ${e.getMessage} when writing to file ${filename}.")
    }
  }

  def main(args: Array[String]) {
    // write succesfully
    writeToFile("output.txt", "I am a string.\nI am also a string.\nScala is fun!\n")

    // read successfully
    readFromFile("output.txt")
  }
}
