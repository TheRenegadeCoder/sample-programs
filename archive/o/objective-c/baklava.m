#import <Foundation/Foundation.h>

// Source:
// https://stackoverflow.com/questions/260945/create-nsstring-by-repeating-another-string-a-given-number-of-times
@interface NSString (Baklava)
- (NSString *) repeatString: (NSUInteger) times;
@end

@implementation NSString (Baklava)
- (NSString *) repeatString: (NSUInteger) times {
    return [
        @"" 
        stringByPaddingToLength: [self length] * times
        withString:self startingAtIndex: 0
    ];
}
@end

int main(int argc, const char * argv[]) {
    NSAutoreleasePool *pool =[[NSAutoreleasePool alloc] init];

    int i;
    for (i = -10; i <= 10; i++) {
        int numSpaces = abs(i);
        int numStars = 21 - 2 * numSpaces;
        printf(
            "%s%s\n",
            [[@" " repeatString: numSpaces] UTF8String],
            [[@"*" repeatString: numStars] UTF8String]
        );
    }

    [pool drain];
    return 0;
}
