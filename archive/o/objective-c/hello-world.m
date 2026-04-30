#import <Foundation/Foundation.h>

int main() {
    @autoreleasepool {
        NSString* message = @"Hello, World!\n";
        printf("%s", message.UTF8String);
    }
}