import "io" for File

File.create("output.txt") {|f|
  f.writeBytes("My brain has too many tabs open.")
}

System.print(File.read("output.txt"))
