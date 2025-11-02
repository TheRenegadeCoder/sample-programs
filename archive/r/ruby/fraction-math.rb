class Fraction
    attr_reader :numerator, :denominator
    def initialize (numerator, denominator)
       @numerator = numerator
       @denominator = denominator
    end 
    
    
  def fraction_math(other_fraction, operator)
    num_one = Rational(@numerator, @denominator)
    num_two = Rational(other_fraction.numerator, other_fraction.denominator)

        final_result = case operator
        when '/' then num_one / num_two
        when '*' then num_one * num_two
        when '+' then num_one + num_two
        when '-' then num_one - num_two 
        else 
            "Invalid operator"
        end
      final_result.to_s
    end      


  # Comparison operators
  def ==(other)
    Rational(@numerator, @denominator) == Rational(other.numerator, other.denominator)
  end

  def !=(other)
    Rational(@numerator, @denominator) != Rational(other.numerator, other.denominator)
  end

  def >=(other)
    Rational(@numerator, @denominator) >= Rational(other.numerator, other.denominator)
  end

  def <=(other)
    Rational(@numerator, @denominator) <= Rational(other.numerator, other.denominator)
  end
  def <(other)
    Rational(@numerator, @denominator) < Rational(other.numerator, other.denominator)
  end

  def >(other)
    Rational(@numerator, @denominator) > Rational(other.numerator, other.denominator)
  end
  
end

# Command-line input
if ARGV.length != 3
  puts "Usage: ./fraction-math operand1 operator operand2"
  exit
end

input1, operator, input2 = ARGV

num1, den1 = input1.split('/').map(&:to_i)
num2, den2 = input2.split('/').map(&:to_i)

fraction1 = Fraction.new(num1, den1)
fraction2 = Fraction.new(num2, den2)

if operator == "+"
  puts fraction1.fraction_math(fraction2,"+")
elsif operator == "-" 
 puts fraction1.fraction_math(fraction2,"-")
elsif operator == "/" 
 puts fraction1.fraction_math(fraction2,"/")
elsif operator == "*" 
 puts fraction1.fraction_math(fraction2,"*")
elsif operator == "=="
  puts fraction1 == fraction2 ? 1 : 0
elsif operator == "!="
  puts fraction1 != fraction2 ? 1 : 0
elsif operator == ">"
  puts fraction1 > fraction2 ? 1 : 0
elsif operator == "<"
  puts fraction1 < fraction2 ? 1 : 0
elsif operator == ">="
  puts fraction1 >= fraction2 ? 1 : 0
elsif operator == "<="
  puts fraction1 <= fraction2 ? 1 : 0
else
  puts "Invalid operator"
end


