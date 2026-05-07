class Fraction
  attr_reader :numerator, :denominator

  def initialize(numerator, denominator)
    @numerator = numerator
    @denominator = denominator
  end

  def to_r
    Rational(numerator, denominator)
  end

  def operate(other, op)
    a = to_r
    b = other.to_r

    case op
    when "+" then (a + b).to_s
    when "-" then (a - b).to_s
    when "*" then (a * b).to_s
    when "/" then (a / b).to_s
    end
  end

  def compare(other, op)
    a = to_r
    b = other.to_r

    case op
    when "==" then a == b
    when "!=" then a != b
    when ">" then a > b
    when "<" then a < b
    when ">=" then a >= b
    when "<=" then a <= b
    end
  end
end

a, op, b = ARGV
abort("Usage: ./fraction-math operand1 operator operand2") unless a && op && b

num1, den1 = a.split("/").map(&:to_i)
num2, den2 = b.split("/").map(&:to_i)

lhs = Fraction.new(num1, den1)
rhs = Fraction.new(num2, den2)

result = lhs.operate(rhs, op)

if !result.nil?
  puts result
else
  cmp = lhs.compare(rhs, op)

  if !cmp.nil?
    puts cmp ? 1 : 0
  else
    puts "Invalid operator"
  end
end
