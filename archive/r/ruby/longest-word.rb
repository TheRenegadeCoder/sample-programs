input_str = ARGV.join(" ").strip 

if input_str.empty?
   puts "Usage: please provide a string"
    exit
  end

  words = input_str.split
        max_length = 0

        words.each do |word|
            if word.length > max_length
              max_length = word.length
            end
          end
          
          puts max_length
