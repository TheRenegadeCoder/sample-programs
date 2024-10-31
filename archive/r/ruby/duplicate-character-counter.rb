# Duplicate Character Counter
if ARGV.length == 0 || ARGV[0] == ''
  puts 'Usage: please provide a string'
else
   hash_count_duplicate_letters = ARGV[0].each_char.with_object(Hash.new(0)) {|a, b| b[a]+=1}
   counter_duplicate_letters = 0
   hash_count_duplicate_letters.each do |key, value|
    if value>1
        puts "#{key}: #{value}"
        counter_duplicate_letters += 1
    end
end
    if counter_duplicate_letters == 0 
        puts "No duplicate characters"
    end 
end
# end
