def write_file
  out = File.new("output.txt", "w")

  out << "This is a line written by a Ruby program\n"
  out << "This line also"

  out.flush()
  out.close()
end


def read_file
  in_file = File.open("output.txt", "r")

  in_file.each_line do |line|
    puts line
  end

  in_file.close()
end

write_file()
read_file()