HEIGHT = 10

(0..HEIGHT).each do |i|
  puts "#{" " * (HEIGHT - i)}#{"*" * (2 * i + 1)}"
end

(HEIGHT - 1).downto(0) do |i|
  puts "#{" " * (HEIGHT - i)}#{"*" * (2 * i + 1)}"
end
