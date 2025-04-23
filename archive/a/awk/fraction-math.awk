function usage() {
    print "Usage: ./fraction-math operand1 operator operand2"
    exit(1)
}

function error(msg) {
    print msg
    exit(1)
}

function str_to_number(s) {
    return (s ~ /^\s*[+-]*[0-9]+\s*$/) ? s + 0 : "ERROR"
}

function str_to_fraction(s, f,  str_arr, idx) {
    # Initialize fraction to 0/1
    f[1] = 0 # numerator
    f[2] = 1 # denominator

    # Split string on "/"
    split(s, str_arr, "/")

    # Error if too many values
    if (length(str_arr) > 2) {
        f[1] = "ERROR"
    } else {
        # Convert each value to number
        for (idx in str_arr) {
            f[idx] = str_to_number(str_arr[idx])
            if (f[idx] == "ERROR") {
                f[1] = "ERROR"
            }
        }

        # If no errors, reduce the fraction
        if (f[1] != "ERROR") {
            fraction_reduce(f[1], f[2], f)
        }
    }
}

function fraction_reduce(n, d, f,  g) {
    # Error if denominator is zero
    if (d == 0) {
        error("Divide by zero")
    }

    # If denominator is negative, negate numerator and denominator
    if (d < 0) {
        n = -n
        d = -d
    }

    # Divide numerator and denominator by GCD
    g = gcd(n, d)
    f[1] = n / g
    f[2] = d / g
}

# Greatest common denominator using Euclidean algorithm
# Source: https://en.wikipedia.org/wiki/Euclidean_algorithm#Implementations
function gcd(a, b,  t) {
    a = abs(a)
    b = abs(b)
    while (b) {
        t = b
        b = a % b
        a = t
    }

    return a
}

function abs(a) {
    return (a >= 0) ? a : -a
}

function fraction_math(f1, op, f2, f,  comp, type) {
    type = "fraction"
    switch (op) {
        case "+":
            fraction_add(f1, f2, f)
            break
        case "-":
            fraction_sub(f1, f2, f)
            break
        case "*":
            fraction_mult(f1, f2, f)
            break
        case "/":
            fraction_div(f1, f2, f)
            break
        default:
            type = "boolean"
            switch (op) {
                case "<":
                    f[1] = fraction_comp(f1, f2) < 0
                    break
                case "<=":
                    f[1] = fraction_comp(f1, f2) <= 0
                    break
                case "==":
                    f[1] = fraction_comp(f1, f2) == 0
                    break
                case "!=":
                    f[1] = fraction_comp(f1, f2) != 0
                    break
                case ">":
                    f[1] = fraction_comp(f1, f2) > 0
                    break
                case ">=":
                    f[1] = fraction_comp(f1, f2) >= 0
                    break
                default:
                    error("Invalid op: " op)
            }
    }

    return type
}

# Fraction addition and subtraction
# n1/d1 +/- n2/d2 = (n1*d2 +/- n2*d1) / (d1*d2)
function fraction_add(f1, f2, f) {
    fraction_reduce(f1[1] * f2[2] + f1[2] * f2[1], f1[2] * f2[2], f)
}

function fraction_sub(f1, f2, f) {
    fraction_reduce(f1[1] * f2[2] - f1[2] * f2[1], f1[2] * f2[2], f)
}

# Fraction multiplication
# n1/d1 * n2/d2 = (n1*n2) / (d1*d2)
function fraction_mult(f1, f2, f) {
    fraction_reduce(f1[1] * f2[1], f1[2] * f2[2], f)
}

# Fraction division
# (n1/d1) / (n2/d2) = (n1*d2) / (n2*d1)
function fraction_div(f1, f2, f) {
    fraction_reduce(f1[1] * f2[2], f1[2] * f2[1], f)
}

# Fraction comparison
# n1/d1 comp n2/d2 = n1*d2 comp n2*d1
#
# Returns:
# - negative if n1/d1 < n2/d2
# - 0 if n1/d1 == n2/d2
# - positive otherwise
function fraction_comp(f1, f2) {
    return f1[1] * f2[2] - f1[2] * f2[1]
}

function fraction_to_str(f, type,  s) {
    if (type == "fraction") {
        s = sprintf("%d/%d", f[1], f[2])
    } else {
        s = f[1] ? "1" : "0"
    }

    return s
}

BEGIN {
    if (ARGC < 4) {
        usage()
    }

    str_to_fraction(ARGV[1], f1)
    str_to_fraction(ARGV[3], f2)
    if (f1[1] == "ERROR" || f2[1] == "ERROR") {
        usage()
    }

    type = fraction_math(f1, ARGV[2], f2, f)
    print(fraction_to_str(f, type))
}
