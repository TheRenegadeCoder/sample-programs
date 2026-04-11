import java.nio.charset.StandardCharsets
import java.nio.file.{Files, Path, Paths}
import scala.jdk.CollectionConverters.*
import scala.util.Try

extension (p: Path)
  def readLines: Try[List[String]] =
    Try(Files.readAllLines(p, StandardCharsets.UTF_8).asScala.toList)

  def writeString(content: String): Try[Unit] =
    Try(Files.writeString(p, content, StandardCharsets.UTF_8)).map(_ => ())

object FileInputOutput:
  private val path = Paths.get("output.txt")
  private val content =
    """I am a string.
      |I am also a string.
      |Scala is fun!""".stripMargin

  @main def run(): Unit =
    val program =
      for
        _ <- path.writeString(content)
        lines <- path.readLines
      yield lines

    program.fold(
      err => System.err.println(s"File operation failed: ${err.getMessage}"),
      res => res.foreach(println)
    )