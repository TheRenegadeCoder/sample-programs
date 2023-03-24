<?php
function usage()
{
    exit("Usage: ./fraction-math operand1 operator operand2");
}

function parse_int($str_value)
{
    // Remove leading and trailing spaces
    $str_value = trim($str_value);

    // Make sure all digits
    if (preg_match("/^[+-]?\d+$/", $str_value) === FALSE)
    {
        return FALSE;
    }

    // Make sure valid integer
    if (
        filter_var(
            $str_value,
            FILTER_VALIDATE_INT,
            array(
                'options' => array(
                    'decimal' => TRUE,
                    'min_range' => PHP_INT_MIN,
                    'max_range' => PHP_INT_MAX
                )
            )
        ) === FALSE
    )
    {
        return FALSE;
    }

    return intval($str_value);
}

function parse_fraction($str_value)
{
    // Split numerator and denonimator
    $str_parts = explode("/", $str_value, 2);

    // Parse numerator. Exit if numerator invalid
    $num = parse_int($str_parts[0]);
    if ($num === FALSE)
    {
        return FALSE;
    }

    // Assume denominator is 1
    $den = 1;

    // If there is denominator,
    if (count($str_parts) > 1)
    {
        // Parse denominator. Exit if denominator invalid
        $den = parse_int($str_parts[1]);
        if ($den === FALSE)
        {
            return FALSE;
        }
    }

    return new Fraction($num, $den);
}

class Fraction
{
    public function __construct(int $num, int $den)
    {
        $this->num = $num;
        $this->den = $den;
    }

    // Fraction addition
    // n1/d1 + n2/d2 = (n1*d2 + n2*d1) / (d1*d2)
    public function add(Fraction $other): Fraction
    {
        return reduce(
            $this->num * $other->den + $other->num * $this->den,
            $this->den * $other->den
        );
    }

    // Fraction subtraction
    // n1/d1 - n2/d2 = (n1*d2 - n2*d1) / (d1*d2)
    public function sub(Fraction $other): Fraction
    {
        return reduce(
            $this->num * $other->den - $other->num * $this->den,
            $this->den * $other->den
        );
    }

    // Fraction multiplication
    // n1/d1 * n2/d2 = (n1*n2) / (d1*d2)
    public function mult(Fraction $other): Fraction
    {
        return reduce($this->num * $other->num, $this->den * $other->den);
    }

    // Fraction division
    // (n1/d1) / (n2/d2) = (n1*d2) / (n2*d1)
    public function div(Fraction $other): Fraction
    {
        return reduce($this->num * $other->den, $other->num * $this->den);
    }

    // Fraction comparison
    // n1/d1 OP n2/d2 = n1*d2 OP n2*d1
    public function cmp(Fraction $other): int
    {
        return $this->num * $other->den - $other->num * $this->den;
    }

    // Show fraction
    public function show()
    {
        echo "{$this->num}/{$this->den}\n";
    }
}

// Fraction reduction
function reduce($num, $den)
{
    if ($den == 0)
    {
        die("Division by 0");
    }

    // Reduce by dividing numerator and denominator by greatest common denominator,
    // and adjust sign of numerator and denominator as follows:
    //
    // n  d  sign n  sign d
    // +  +     +       +
    // +  -     -       +
    // -  +     -       +
    // -  -     +       +
    $den_sign = ($den > 0) ? 1 : -1;
    $g = gcd($num, $den);
    return new Fraction(intdiv($den_sign * $num, $g), intdiv(abs($den), $g));
}

// Greatest common denominator
function gcd($a, $b)
{
    $a = abs($a);
    $b = abs($b);
    while ($b != 0)
    {
        $t = $b;
        $b = $a % $b;
        $a = $t;
    }

    return $a;
}

// Do fraction math
function fraction_math(Fraction $f1, Fraction $f2, string $op): Fraction|bool
{
    switch ($op)
    {
        case "+":
            return $f1->add($f2);
        case "-":
            return $f1->sub($f2);
        case "*":
            return $f1->mult($f2);
        case "/":
            return $f1->div($f2);
        case ">":
            return $f1->cmp($f2) > 0;
        case ">=":
            return $f1->cmp($f2) >= 0;
        case "<":
            return $f1->cmp($f2) < 0;
        case "<=":
            return $f1->cmp($f2) <= 0;
        case "==":
            return $f1->cmp($f2) == 0;
        case "!=":
            return $f1->cmp($f2) != 0;
        default:
            die("Invalid operator ${op}");
    }
}

// Show fraction result
function show_fraction_result(Fraction|int $value)
{
    if (gettype($value) == "object")
    {
        $value->show();
    }
    else
    {
        echo "${value}\n";
    }
}

// Exit if too few arguments or 2nd argument is empty
if (count($argv) < 4 || empty($argv[2]))
{
    usage();
}

// Parse 1st and 3rd arguments. Exit if invalid
$f1 = parse_fraction($argv[1]);
$f2 = parse_fraction($argv[3]);
if ($f1 === FALSE || $f2 == FALSE)
{
    usage();
}

// Do fraction math and show result
$op = $argv[2];
$result = fraction_math($f1, $f2, $op);
show_fraction_result($result);
