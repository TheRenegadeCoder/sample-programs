class Capitalize {
  static void main(String... args) {
    if(args?.length >= 1 && args[0]?.length() >= 1) {
      println args[0]?.capitalize()
    }
    else {
      println "Usage: please provide a string"
    }
  }
}
