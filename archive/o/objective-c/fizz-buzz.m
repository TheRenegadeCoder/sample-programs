#import <Foundation/Foundation.h>

int main (int argc, const char *argv[]){
    NSAutoreleasePool *pool =[[NSAutoreleasePool alloc] init];
    NSMutableString* fizzbuzz = [[NSMutableString alloc] init];

    int i;
    for (i = 1; i <= 100; ++i) {
        [fizzbuzz setString: @""];

        if (i % 3 == 0) {
            [fizzbuzz appendString: @"Fizz"];
        }

        if (i % 5 == 0) {
            [fizzbuzz appendString: @"Buzz"];
        }

        if ([fizzbuzz length] != 0) {
            NSLog(fizzbuzz);

        } else {
            NSLog(@"%d", i);
        }
    }

    [fizzbuzz release];
    [pool drain];
    return 0;
}
