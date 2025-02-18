def sum_of_digits(n)
    sum = 0

    digits = n.to_s.char
    digits.each do |digits|
        sum += digits.to_i
    end
    
    sum
end

n = gets.to_i
puts sum_of_digits(n)