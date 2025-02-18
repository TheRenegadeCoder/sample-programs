input_str = ARGV.join(" ").strip 

if input_str.empty?
    puts "please provide a string"
    exit
  end

  words = input_str.split
        max_length = 0
