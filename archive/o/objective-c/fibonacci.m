#import <Foundation/Foundation.h>

// Function to convert and validate the input string
// Source: ChatGPT
NSInteger convertAndValidateInput(NSString *inputString) {
    NSScanner *scanner = [NSScanner scannerWithString:inputString];
    NSInteger integerValue = 0;

    // Check if the scanner successfully scanned an integer
    if ([scanner scanInteger:&integerValue] && [scanner isAtEnd]) {
        return integerValue;
    } else {
        // Raise an exception for invalid input
        @throw [NSException exceptionWithName:@"InvalidInputException"
            reason:@"Input is not a valid integer"
            userInfo:nil];
    }
}

void fibonacci(int n)
{
    int a = 0;
    int b = 1;
    int c;
    int i = 1;
    while (i <= n) {
        c = a + b;
        a = b;
        b = c;
        printf("%d: %d\n", i, a);
        i++;
    }
}

int main(int argc, const char * argv[]) {
    NSAutoreleasePool *pool =[[NSAutoreleasePool alloc] init];
    NSString *usage = @"Usage: please input the count of fibonacci numbers to output";
    if (argc < 2) {
        printf("%s\n", [usage UTF8String]);
    }
    else {
        NSString* inputStr = [NSString stringWithUTF8String:argv[1]];
        @try {
            int input = (int)convertAndValidateInput(inputStr);
            fibonacci(input);
        }
        @catch (NSException *) {
            printf("%s\n", [usage UTF8String]);
        }
    }
    [pool drain];
    return 0;
}
