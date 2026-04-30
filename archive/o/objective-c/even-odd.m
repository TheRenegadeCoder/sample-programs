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

int main(int argc, const char* argv[]) {
    @autoreleasepool {
        if (argc < 2) {
            puts("Usage: please input a number");
            return 1;
        }

        NSNumber* number = @(argv[1]).strictIntegerNumber;

        if (!number) {
            puts("Usage: please input a number");
            return 1;
        }

        puts(number.longLongValue % 2 == 0 ? "Even" : "Odd");
    }
    return 0;
}