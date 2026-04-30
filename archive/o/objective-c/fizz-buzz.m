#import <Foundation/Foundation.h>

int main(int argc, const char* argv[]) {
    @autoreleasepool {
        NSMutableString* output = [NSMutableString stringWithCapacity:8];

        for (NSInteger i = 1; i <= 100; i++) {
            [output setString:@""];

            if (i % 3 == 0) [output appendString:@"Fizz"];
            if (i % 5 == 0) [output appendString:@"Buzz"];

            if (output.length > 0) {
                printf("%s\n", output.UTF8String);
            } else {
                printf("%ld\n", (long)i);
            }
        }
    }
    return 0;
}
