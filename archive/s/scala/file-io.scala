import scala.io.Source
import java.io.{FileNotFoundException, IOException, File, FileOutputStream, PrintWriter}

object FileIO {
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

  // reading file into Option type using generators
  // fail silently
  def readFromFileIntoOption(filename: String): Option[List[String]] = {
    try {
      val buffer = Source.fromFile(filename)
      val lines = (
        for (line <- buffer.getLines)
          yield line
        ).toList

      buffer.close
      Some(lines)
    } catch {
      // any exception will results to None
      case e: Exception => None
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

  // using Option to wrap writing to file
  // with this method, if we can't write to file, nothing will be executed
  def optionWriteToFile(filename: String, contents: String) {
    val writer: Option[PrintWriter] =
    try {
      Some(new PrintWriter(new File(filename)))
    } catch {
      case e: Exception => None
    }
    writer.foreach { w => w.write(contents); w.close }
  }

  def main(args: Array[String]) {
    // usages:

    // read successfully
    println("readFromFile:")
    readFromFile("input.txt")

    println("readFromFileIntoOption:")
    val lines = readFromFileIntoOption("input.txt")
    lines.map(_.foreach(println))

    // read failing
    println("readFromFile non-exist:")
    readFromFile("non-exist.txt")

    println("readFromFile not-permitted:")
    readFromFile("not-permitted.txt")

    // read silently failing
    println("readFromFileIntoOption non-exist:")
    val optionLines = readFromFileIntoOption("non-exist.txt")
    optionLines.map(_.foreach(println))

    println("readFromFileIntoOption not-permitted:")
    val anotherOptionLines = readFromFileIntoOption("not-permitted.txt")
    anotherOptionLines.map(_.foreach(println))


    // write succesfully
    println("writeToFile:")
    writeToFile("output.txt", "I am a string.\n")

    println("optionWriteToFile:")
    optionWriteToFile("output2.txt", "There another string.\n")

    // write failing
    println("writeToFile not-permitted:")
    writeToFile("not-permitted.txt", "Can I write to this file?")

    // write silently failing
    println("optionWriteToFile not-permitted:")
    optionWriteToFile("not-permitted.txt", "Can I write to this file?")
  }
}
