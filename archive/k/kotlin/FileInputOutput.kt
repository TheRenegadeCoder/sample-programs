import java.io.File
import java.nio.charset.Charset

fun main(args: Array<String>) {

    val fileName = "output.txt"

    val file = File(fileName)

    if(file.exists()){
        val output = file.readText(Charset.defaultCharset())
        println(output)
    } else{
        try {
            file.createNewFile()
            file.writeText("Hello, World!")
            val output = file.readText(Charset.defaultCharset())
            println(output)
        }catch (e :Exception){
            println("File could not be created!")
        }
    }
}
