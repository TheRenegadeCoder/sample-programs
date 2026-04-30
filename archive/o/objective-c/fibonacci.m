#import <Foundation/Foundation.h>

@interface NSString (Parsing)
@property(nonatomic, readonly, nullable) NSNumber* strictIntegerNumber;
@end

@implementation NSString (Parsing)

- (NSNumber*)strictIntegerNumber {
    NSString* trimmed = [self
        stringByTrimmingCharactersInSet:NSCharacterSet
                                            .whitespaceAndNewlineCharacterSet];
    if (trimmed.length == 0) return nil;

    NSInteger offset = 0;
    if ([trimmed hasPrefix:@"-"] || [trimmed hasPrefix:@"+"]) {
        offset = 1;
    }

    if (trimmed.length <= offset) return nil;

    NSString* core = [trimmed substringFromIndex:offset];
    NSRange invalidRange =
        [core rangeOfCharacterFromSet:NSCharacterSet.decimalDigitCharacterSet
                                          .invertedSet];

    if (invalidRange.location != NSNotFound) {
        return nil;
    }

    return @(trimmed.longLongValue);
}

@end

static void PrintFibonacciSequence(NSUInteger count) {
    unsigned long long previous = 0;
    unsigned long long current = 1;

    for (NSUInteger i = 1; i <= count; i++) {
        printf("%ld: %llu\n", i, current);

        unsigned long long next = previous + current;
        previous = current;
        current = next;
    }
}

int main(int argc, const char* argv[]) {
    @autoreleasepool {
        const char* usage =
            "Usage: please input the count of fibonacci numbers to output";

        if (argc < 2) {
            puts(usage);
            return 1;
        }

        NSNumber* number = @(argv[1]).strictIntegerNumber;

        if (!number || number.integerValue < 0) {
            puts(usage);
            return 1;
        }

        PrintFibonacciSequence(number.unsignedIntegerValue);
    }
    return 0;
}
