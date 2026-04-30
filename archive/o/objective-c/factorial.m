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

static unsigned long long Factorial(NSUInteger n) {
    if (n == 0 || n == 1) return 1;

    unsigned long long result = 1;
    for (NSUInteger i = 2; i <= n; i++) {
        result *= i;
    }

    return result;
}

int main(int argc, const char* argv[]) {
    @autoreleasepool {
        const char* usage = "Usage: please input a non-negative integer";
        if (argc < 2) {
            puts(usage);
            return 1;
        }

        NSNumber* number = @(argv[1]).strictIntegerNumber;

        if (!number || number.integerValue < 0) {
            puts(usage);
            return 1;
        }

        printf("%llu\n", Factorial(number.unsignedIntegerValue));
    }
    return 0;
}