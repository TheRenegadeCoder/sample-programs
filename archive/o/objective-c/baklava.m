#import <Foundation/Foundation.h>

int main() {
    @autoreleasepool {
        const NSInteger radius = 10;

        for (NSInteger i = -radius; i <= radius; i++) {
            NSUInteger paddingCount = (NSUInteger)labs(i);
            NSUInteger starCount = (radius - paddingCount) * 2 + 1;

            NSString* padding = [@"" stringByPaddingToLength:paddingCount
                                                  withString:@" "
                                             startingAtIndex:0];

            NSString* stars = [@"" stringByPaddingToLength:starCount
                                                withString:@"*"
                                           startingAtIndex:0];

            NSString* line = [padding stringByAppendingString:stars];

            puts(line.UTF8String);
        }
    }
    return 0;
}