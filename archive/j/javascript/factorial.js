/**
 * Calculate the factorial of a given integer input.
 * 
 * @param {Integer} num 
 */
function factorial(num) {
    let product = 1;
    if ( num > 1 ) {
        for ( let i = 2; i <= num; i++ ) {
            product *= i
        }
    }
    return product
}

/**
 * Executable function
 * 
 * @param {Command line input} input 
 */
function main(input) {
    // Usage text
    const usage = 'Usage: please input a non-negative integer';

    // No input
    if ( !input ) {
        console.log(usage)
        return
    }

    /**
     * If we remove all the integer characters from the input and are left with
     * an empty string, then we have a valid integer.
     */
    const inputValidation = input.replace(/[0-9]/g,'')
    
    if ( inputValidation === '' ) {
        // Valid integer
        const parsedInput = parseInt(input)
        if ( parsedInput < 0 ) {
            console.log(usage)
        }
        else if ( parsedInput > 170 ) {
            console.log(`Input of ${parsedInput} is too large to calculate a factorial for. Max input is 170.`)
        }
        else {
            console.log(factorial(parsedInput))
        }
    }
    else {
        // Anything non integer
        console.log(usage)
    }
    
}

// Run the executable function
const input = process.argv[2]
main(input)