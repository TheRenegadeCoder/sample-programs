#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int numerator;
    int denominator;
} Fraction;

int gcd(int a, int b) {
    if (b == 0) return a;
    return gcd(b, a % b);
}

Fraction simplify(Fraction f) {
    int g = gcd(abs(f.numerator), abs(f.denominator));
    f.numerator /= g;
    f.denominator /= g;
    if (f.denominator < 0) {
        f.numerator = -f.numerator;
        f.denominator = -f.denominator;
    }
    return f;
}

Fraction parse_fraction(const char* str) {
    Fraction f;
    sscanf(str, "%d/%d", &f.numerator, &f.denominator);
    return simplify(f);
}

Fraction add(Fraction a, Fraction b) {
    Fraction result = {
        a.numerator * b.denominator + b.numerator * a.denominator,
        a.denominator * b.denominator
    };
    return simplify(result);
}

Fraction subtract(Fraction a, Fraction b) {
    Fraction result = {
        a.numerator * b.denominator - b.numerator * a.denominator,
        a.denominator * b.denominator
    };
    return simplify(result);
}

Fraction multiply(Fraction a, Fraction b) {
    Fraction result = {
        a.numerator * b.numerator,
        a.denominator * b.denominator
    };
    return simplify(result);
}

Fraction divide(Fraction a, Fraction b) {
    Fraction result = {
        a.numerator * b.denominator,
        a.denominator * b.numerator
    };
    return simplify(result);
}

int compare(Fraction a, Fraction b) {
    int lhs = a.numerator * b.denominator;
    int rhs = b.numerator * a.denominator;
    if (lhs < rhs) return -1;
    if (lhs > rhs) return 1;
    return 0;
}

void print_fraction(Fraction f) {
    printf("%d/%d\n", f.numerator, f.denominator);
}

int main(int argc, char* argv[]) {
    if (argc != 4) {
        printf("Usage: ./fraction-math operand1 operator operand2\n");
        return 1;
    }

    Fraction a = parse_fraction(argv[1]);
    Fraction b = parse_fraction(argv[3]);
    char* op = argv[2];

    Fraction result;
    int cmp;

    if (strcmp(op, "+") == 0) {
        result = add(a, b);
        print_fraction(result);
    } else if (strcmp(op, "-") == 0) {
        result = subtract(a, b);
        print_fraction(result);
    } else if (strcmp(op, "*") == 0) {
        result = multiply(a, b);
        print_fraction(result);
    } else if (strcmp(op, "/") == 0) {
        result = divide(a, b);
        print_fraction(result);
    } else if (strcmp(op, "==") == 0) {
        cmp = compare(a, b);
        printf("%d\n", cmp == 0);
    } else if (strcmp(op, ">") == 0) {
        cmp = compare(a, b);
        printf("%d\n", cmp > 0);
    } else if (strcmp(op, "<") == 0) {
        cmp = compare(a, b);
        printf("%d\n", cmp < 0);
    } else if (strcmp(op, ">=") == 0) {
        cmp = compare(a, b);
        printf("%d\n", cmp >= 0);
    } else if (strcmp(op, "<=") == 0) {
        cmp = compare(a, b);
        printf("%d\n", cmp <= 0);
    } else if (strcmp(op, "!=") == 0) {
        cmp = compare(a, b);
        printf("%d\n", cmp != 0);
    } else {
        printf("Invalid operator\n");
        return 1;
    }

    return 0;
}
