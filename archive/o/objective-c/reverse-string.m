#import <Foundation/Foundation.h>

@interface NSString (Reversal)
@property(nonatomic, readonly) NSString* reversed;
@end

@implementation NSString (Reversal)

- (NSString*)reversed {
    NSUInteger len = self.length;
    if (len < 2) return self;

    unichar buffer[len];
    [self getCharacters:buffer range:NSMakeRange(0, len)];

    NSUInteger i = 0;
    NSUInteger j = len - 1;

    while (i < j) {
        unichar tmp = buffer[i];
        buffer[i++] = buffer[j];
        buffer[j--] = tmp;
    }

    return [NSString stringWithCharacters:buffer length:len];
}

@end

int main(int argc, const char* argv[]) {
    @autoreleasepool {
        NSString* input = argc > 1 ? @(argv[1]) : nil;
        NSString* output = input.reversed;
        puts(output.UTF8String);
    }
    return 0;
}
