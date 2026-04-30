#import <Foundation/Foundation.h>

@interface NSString (CapitalizeFirst)
- (nullable NSString*)stringByCapitalizingFirstCharacter;
@end

@implementation NSString (CapitalizeFirst)

- (NSString*)stringByCapitalizingFirstCharacter {
    if (self.length == 0) return nil;

    NSRange firstCharRange = [self rangeOfComposedCharacterSequenceAtIndex:0];
    NSString* firstLetter =
        [[self substringWithRange:firstCharRange] uppercaseString];

    return [self stringByReplacingCharactersInRange:firstCharRange
                                         withString:firstLetter];
}

@end

int main(int argc, const char* argv[]) {
    @autoreleasepool {
        NSString* usage = @"Usage: please provide a string";
        NSString* input = argc > 1 ? @(argv[1]) : @"";

        NSString* trimmed =
            [input stringByTrimmingCharactersInSet:
                       NSCharacterSet.whitespaceAndNewlineCharacterSet];

        NSString* result = [trimmed stringByCapitalizingFirstCharacter];

        puts((result ?: usage).UTF8String);
    }

    return 0;
}
