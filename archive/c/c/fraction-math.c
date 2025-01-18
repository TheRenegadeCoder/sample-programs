#include <stdio.h>

// Structure to represent a fraction
typedef struct {
    int numerator;
    int denominator;
} Fraction;

// Function to simplify a fraction
Fraction simplify(Fraction frac) {
    int gcd = 1;
    for (int i = 1; i <= frac.numerator && i <= frac.denominator; i++) {
        if (frac.numerator % i == 0 && frac.denominator % i == 0) {
            gcd = i;
        }
    }
    frac.numerator /= gcd;
    frac.denominator /= gcd;
    return frac;
}

// Function to add two fractions
Fraction add(Fraction a, Fraction b) {
    Fraction result;
    result.numerator = a.numerator * b.denominator + b.numerator * a.denominator;
    result.denominator = a.denominator * b.denominator;
    return simplify(result);
}

// Function to subtract two fractions
Fraction subtract(Fraction a, Fraction b) {
    Fraction result;
    result.numerator = a.numerator * b.denominator - b.numerator * a.denominator;
    result.denominator = a.denominator * b.denominator;
    return simplify(result);
}

// Function to multiply two fractions
Fraction multiply(Fraction a, Fraction b) {
    Fraction result;
    result.numerator = a.numerator * b.numerator;
    result.denominator = a.denominator * b.denominator;
    return simplify(result);
}

// Function to divide two fractions
Fraction divide(Fraction a, Fraction b) {
    Fraction result;
    result.numerator = a.numerator * b.denominator;
    result.denominator = a.denominator * b.numerator;
    return simplify(result);
}

// Function to print a fraction
void printFraction(Fraction frac) {
    printf("%d/%d\n", frac.numerator, frac.denominator);
}

int main() {
    Fraction frac1, frac2, result;

    // Input for first fraction
    printf("Enter first fraction (numerator denominator): ");
    scanf("%d %d", &frac1.numerator, &frac1.denominator);

    // Input for second fraction
    printf("Enter second fraction (numerator denominator): ");
    scanf("%d %d", &frac2.numerator, &frac2.denominator);

    // Add fractions
    result = add(frac1, frac2);
    printf("Sum: ");
    printFraction(result);

    // Subtract fractions
    result = subtract(frac1, frac2);
    printf("Difference: ");
    printFraction(result);

    // Multiply fractions
    result = multiply(frac1, frac2);
    printf("Product: ");
    printFraction(result);

    // Divide fractions
    if (frac2.numerator != 0) {
        result = divide(frac1, frac2);
        printf("Quotient: ");
        printFraction(result);
    } else {
        printf("Error: Division by zero.\n");
    }

    return 0;
}
