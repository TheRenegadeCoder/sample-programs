fun main(args: Array<String>) {
  var num = readLine()!!.toIntOrNull()
  if(num == null){
    print("Usage: please input a number")
    return
  }
  if(num%2 == 0)
  {
    println("Even")
  }
  else
  {
    println("Odd")
  }
}