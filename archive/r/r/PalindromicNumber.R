def palindromic?(number)
  number.to_s == number.to_s.reverse
end 

puts palindromic?(326)  
puts palindromic?(545)  