function [] = fizzBuzz(x)

  % Loop from 1 to 100
  for i = 1:100
    fizzbuzz = '';
    
    % Check if i is divisible by 3
    if mod(i,3) == 0
      fizzbuzz = [fizzbuzz 'Fizz'];
    end
    
    % Check if i is divisible by 5
    if mod(i,5) == 0
      fizzbuzz = [fizzbuzz 'Buzz'];
    end
    
    % If fizzbuzz variable is empty,print i
    if isempty(fizzbuzz)
      disp(i)
    else
      % If fizzbuzz variable is not empty, print the variable
      disp(fizzbuzz)
    end
  end
end