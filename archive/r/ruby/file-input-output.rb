content = <<~TEXT
  This is a line written by a Ruby program
  This line also
TEXT

File.write("output.txt", content)

File.foreach("output.txt") do |line|
  puts line
end
